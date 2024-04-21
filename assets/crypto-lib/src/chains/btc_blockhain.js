import bs58 from "bs58";


export class BitcoinBlockchain {
  concatenateUint8Arrays(arr1, arr2) {
    const concatenated = new Uint8Array(arr1.length + arr2.length);
    concatenated.set(arr1);
    concatenated.set(arr2, arr1.length);
    return concatenated;
  }
  
  isValidPrivateKeyBitcoin(secretKey){
    const { Base58, PrivateKey, Curve } = window.WalletCore;
    const decodedSecretKey = Base58.decode(secretKey);
    console.log(PrivateKey.isValid(decodedSecretKey, Curve.secp256k1));
  }
 
  getBase58PubKeyFromHexValue(publicKey) {
    const { HexCoding } = window.WalletCore;
    const publicKeyDecoded = HexCoding.decode(`0x${publicKey}`);
    return publicKeyDecoded;
  }

  getAdressBTCFromHexPublicKeyP2PKH(publicKeyHEX, needKeyHash){
    const { BitcoinAddress, HexCoding, PublicKey, PublicKeyType} = window.WalletCore;
    const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
    const adressBTC = BitcoinAddress.createWithPublicKey(publicKeyDecode, 0x00);
    if (needKeyHash){
      return adressBTC.keyhash();
    } else {
      return adressBTC.description();
    }
  }


  getAdressBTCFromHexPublicKeySegWit(publicKeyHEX){
  const { PublicKey, HexCoding, PublicKeyType, AnyAddress, CoinType } = window.WalletCore;
  const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(publicKeyHEX), PublicKeyType.secp256k1);
  const address = AnyAddress.createBech32WithPublicKey(publicKeyDecode, CoinType.bitcoin, 'bc');

  return address.description()
}

getBlockChainDataFromMnemonic(
  mnemonic,
  passphrase = "",
  account = "0'",
  change = "0",
  address = "0"
) {
  const { CoinType, HDWallet, BitcoinAddress } = window.WalletCore;
  const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
  const derivationPath = `m/84'/0'/${account}/${change}/${address}`;// m/44 - legacy
  const privateKey = wallet.getKey(CoinType.bitcoin, derivationPath);
  const AddressBTC = wallet.getAddressForCoin(CoinType.bitcoin) //adress for SegWit 
  const privateKeyString = bs58.encode(privateKey.data());
  const publicKey = privateKey.getPublicKeySecp256k1(true);
  // const adressBTC = BitcoinAddress.createWithPublicKey(publicKey, 0x00);// adress for p2pkh
  return JSON.stringify({
    mnemonic: wallet.mnemonic(),
    publicKey: publicKey.description(),
    accountId: AddressBTC,
    privateKey: privateKeyString,
    passphrase: passphrase,
    derivationPath: {
      purpose: "84'",
      coinType: "0'",
      accountNumber: account,
      change: change,
      address: address,
    },
  });
}


getBlockChainDataFromMnemonicLegaceP2PKH(
  mnemonic,
  passphrase = "",
  account = "0'",
  change = "0",
  address = "0"
) {
  const { CoinType, HDWallet, BitcoinAddress } = window.WalletCore;
  const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
  const derivationPath = `m/44'/0'/${account}/${change}/${address}`;// m/44 - legacy
  const privateKey = wallet.getKey(CoinType.bitcoin, derivationPath);
  // const AddressBTC = wallet.getAddressForCoin(CoinType.bitcoin) //adress for SegWit 
  const privateKeyString = bs58.encode(privateKey.data());
  const publicKey = privateKey.getPublicKeySecp256k1(true);
  const adressBTC = BitcoinAddress.createWithPublicKey(publicKey, 0x00);// adress for p2pkh
  return JSON.stringify({
    mnemonic: wallet.mnemonic(),
    publicKey: publicKey.description(),
    accountId: adressBTC.description(),
    privateKey: privateKeyString,
    passphrase: passphrase,
    derivationPath: {
      purpose: "44'",
      coinType: "0'",
      accountNumber: account,
      change: change,
      address: address,
    },
  });
}


buildPayToPublicKeyHash(publicKeyHEX){
  const { BitcoinScript } = window.WalletCore;
  const needKeyHash = true;
  const utxoPubkeyHash = this.getAdressBTCFromHexPublicKeyP2PKH(publicKeyHEX, needKeyHash);
  const buildPayToPublicKeyHash = BitcoinScript.buildPayToPublicKeyHash(utxoPubkeyHash);
    
  return buildPayToPublicKeyHash.data();
}


buildPayToWeetnesPublicKeyHash(publicKeyHEX){
  const { BitcoinScript, CoinType, HexCoding, Hash } = window.WalletCore;
  const hexString = HexCoding.decode(publicKeyHEX);
  const heash = Hash.ripemd(Hash.sha256(hexString));
  const buildPayToWeetnesPublicKeyHash = BitcoinScript.buildPayToWitnessPubkeyHash(heash);

  return buildPayToWeetnesPublicKeyHash.data();
}




buildPayToFormat(format, publicKey){
  if (format == 'P2PKH'){
    return this.buildPayToPublicKeyHash(publicKey);
  } else if (format == 'SEGWIT'){
    return this.buildPayToWeetnesPublicKeyHash(publicKey);
  } else {
    throw new Error('Error. This format is not recognized or implemented');
  }
}

test (data){
  const {TW} = window;
  const { HexCoding } = WalletCore;
   const newdata = data.map((e) => {
    return  TW.Bitcoin.Proto.OutPoint.create({
    hash: HexCoding.decode(e['tx_hash']).reverse(),
    index: e['tx_output'],
    sequence: 4294967295
  })});
    return newdata;
}

bitcoinTransferAction(toAddress, accountID, transferAmount, privateKeyHex, publicKey, dataFromUTXO, format, feeBayte){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode(privateKeyHex);
    const sscript = this.buildPayToFormat(format, publicKey);

    const datautxo = dataFromUTXO.map((data) => { 
      return TW.Bitcoin.Proto.UnspentTransaction.create({
        outPoint: TW.Bitcoin.Proto.OutPoint.create({
          hash: HexCoding.decode(data['tx_hash']).reverse(),
          index: data['tx_output'],
          sequence: 4294967295
        }),
      amount: data['ref_balance'],
      script: sscript
      })});
    
    const input = TW.Bitcoin.Proto.SigningInput.create({
      hashType: BitcoinScript.hashTypeForCoin(CoinType.bitcoin),
      amount: transferAmount,
      byteFee: feeBayte,
      toAddress: toAddress,
      changeAddress: accountID,
      utxo: datautxo,
      privateKey: [Uint8Array.from(privateKey)],
      сoinType: CoinType.bitcoin,
      useMaxUtxo: true,
    });

    const encodedForPlan = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
    const outputDataForPlan = AnySigner.plan(encodedForPlan, CoinType.bitcoin);
    const outputForPlan = TW.Bitcoin.Proto.TransactionPlan.decode(outputDataForPlan);
    input.plan = outputForPlan;
    
    const encoded = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
    const outputData = AnySigner.sign(encoded, CoinType.bitcoin);
    const output = TW.Bitcoin.Proto.SigningOutput.decode(outputData);
    if (output.error != 0){
      return output.error
    }
    const hexEncodedOutput = HexCoding.encode(output.encoded);
    return hexEncodedOutput.substring(2);
  } catch  (error) {
    console.error(JSON.stringify(error));
    return JSON.stringify({ error: error.message });
  }
}

bitcoinTransferActionCopy(toAddress, accountID, transferAmount, privateKeyHex, publicKey, tx_hash, utxoAmount, tx_output, format, feeBayte){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode(privateKeyHex);
    const utxoTxId = HexCoding.decode(tx_hash);
    const sscript = this.buildPayToFormat(format, publicKey);
    const outPoint = TW.Bitcoin.Proto.OutPoint.create({
      hash: utxoTxId.reverse(),
      index: tx_output,
      sequence: 4294967295
    });
    const utxo = TW.Bitcoin.Proto.UnspentTransaction.create({
      outPoint: outPoint,
      amount: utxoAmount,
      script: sscript
    });
    
    const input = TW.Bitcoin.Proto.SigningInput.create({
      hashType: BitcoinScript.hashTypeForCoin(CoinType.bitcoin),
      amount: transferAmount,
      byteFee: feeBayte,
      toAddress: toAddress,
      changeAddress: accountID,
      utxo: [utxo],
      privateKey: [Uint8Array.from(privateKey)],
      сoinType: CoinType.bitcoin
    });

    const encodedForPlan = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
    const outputDataForPlan = AnySigner.plan(encodedForPlan, CoinType.bitcoin);
    const outputForPlan = TW.Bitcoin.Proto.TransactionPlan.decode(outputDataForPlan);
    input.plan = outputForPlan;
    
    const encoded = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
    const outputData = AnySigner.sign(encoded, CoinType.bitcoin);
    const output = TW.Bitcoin.Proto.SigningOutput.decode(outputData);
    if (output.error != 0){
      return output.error
    }
    const hexEncodedOutput = HexCoding.encode(output.encoded);
    return hexEncodedOutput.substring(2);
  } catch  (error) {
    console.error(JSON.stringify(error));
    return JSON.stringify({ error: error.message });
  }
}

}
