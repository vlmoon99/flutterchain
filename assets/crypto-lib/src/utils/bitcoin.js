import * as bitcoin from "bitcoinjs-lib";

export class BitcoinUtils {
  
  createPayload(
    sender,
    receiver,
    satoshis,
    utxos,
    txInfos,
    feeRate,
    network
  ) {
    utxos = JSON.parse(utxos);
    txInfos = JSON.parse(txInfos);

    network =
      network === "testnet"
        ? bitcoin.networks.testnet
        : bitcoin.networks.bitcoin;

    const psbt = new bitcoin.Psbt({ network: network });

    let totalInput = 0;

    utxos.map(async (utxo) => {
      totalInput += utxo.value;

      const transaction = this.extractTxFromTxInfo(txInfos[utxo.txid]);

      let inputOptions;
      if (transaction.outs[utxo.vout].script.includes("0014")) {
        inputOptions = {
          hash: utxo.txid,
          index: utxo.vout,
          witnessUtxo: {
            script: transaction.outs[utxo.vout].script,
            value: utxo.value,
          },
        };
      } else {
        inputOptions = {
          hash: utxo.txid,
          index: utxo.vout,
          nonWitnessUtxo: Buffer.from(transaction.toHex(), "hex"),
        };
      }

      psbt.addInput(inputOptions);
    });

    psbt.addOutput({
      address: receiver,
      value: Number(satoshis),
    });

    const estimatedSize = utxos.length * 148 + 2 * 34 + 10;
    const fee = estimatedSize * (feeRate + 3);

    const change = totalInput - Number(satoshis) - fee;
    if (change > 0) {
      psbt.addOutput({
        address: sender,
        value: change,
      });
    }

    return JSON.stringify(psbt.toHex());
  }

  signTransactionWithMPCSignature(psbtHex, signatures, publicKey) {
    const psbt = bitcoin.Psbt.fromHex(psbtHex);
    signatures = JSON.parse(signatures);
    publicKey = Buffer.from(publicKey, "hex");
    // Bitcoin needs to sign multiple utxos, so we need to pass a signer function
    for (let index = 0; index < signatures.length; index++) {
      const sign = (tx) => {
        const big_r = signatures[index].big_r;
        const big_s = signatures[index].big_s;
        return this.reconstructSignature(big_r, big_s);
      }
      psbt.signInput(index, { publicKey, sign });
    }

    psbt.finalizeAllInputs();

    return JSON.stringify(psbt.extractTransaction().toHex());
  }

  reconstructSignature(big_r, big_s) {
    const r = big_r.slice(2).padStart(64, "0");
    const s = big_s.padStart(64, "0");

    const rawSignature = Buffer.from(r + s, "hex");

    if (rawSignature.length !== 64) {
      throw new Error("Invalid signature length.");
    }

    return rawSignature;
  }

  getReversedPayloadsToSignForMPC(psbtHex, utxos, publicKey) {
    utxos = JSON.parse(utxos);
    publicKey = Buffer.from(publicKey, "hex");
    const psbt = bitcoin.Psbt.fromHex(psbtHex);

    let txs = [];

    const sign = (tx) => {
      const txReversed = Array.from(tx).reverse();
      txs.push(txReversed);
      const mockR = new Uint8Array(64).fill(0);
      const mockS = new Uint8Array(64).fill(0);
      return Buffer.from(mockR + mockS, "hex");
    }

    utxos.map(async (_, index) => {
      psbt.signInput(index, { publicKey, sign });
    });

    return JSON.stringify(txs);
  } 

  extractTxFromTxInfo(txData) {
    const data = txData;

    const tx = new bitcoin.Transaction();

    tx.version = data.version;
    tx.locktime = data.locktime;

    data.vin.forEach((vin) => {
      const txHash = Buffer.from(vin.txid, "hex").reverse();
      const vout = vin.vout;
      const sequence = vin.sequence;
      const scriptSig = vin.scriptsig
        ? Buffer.from(vin.scriptsig, "hex")
        : undefined;
      tx.addInput(txHash, vout, sequence, scriptSig);
    });

    data.vout.forEach((vout) => {
      const value = vout.value;
      const scriptPubKey = Buffer.from(vout.scriptpubkey, "hex");
      tx.addOutput(scriptPubKey, value);
    });

    data.vin.forEach((vin, index) => {
      if (vin.witness && vin.witness.length > 0) {
        const witness = vin.witness.map((w) => Buffer.from(w, "hex"));
        tx.setWitness(index, witness);
      }
    });

    return tx;
  }
}
