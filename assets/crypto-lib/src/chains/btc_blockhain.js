import BN from "bn.js";
import Long from "long";
import bs58 from "bs58";
import nacl from "tweetnacl";

export class BitcoinBlockchain {
  concatenateUint8Arrays(arr1, arr2) {
    const concatenated = new Uint8Array(arr1.length + arr2.length);
    concatenated.set(arr1);
    concatenated.set(arr2, arr1.length);
    return concatenated;
  }
  getPublicKeyFromSecretKeyFromNearApiJSFormat(secretKey) {
    const { HexCoding } = window.WalletCore;
    const decodedSecretKey = bs58.decode(secretKey);
    const keyPair = nacl.sign.keyPair.fromSecretKey(decodedSecretKey);
    return HexCoding.encode(keyPair.publicKey).substring(2);
  }
  getPrivateKeyFromSecretKeyFromNearApiJSFormat(secretKey) {
    const { Base58, Base64, PrivateKey, Curve } = window.WalletCore;

    const decodedSecretKey = Base58.decodeNoCheck(secretKey);
    const privateKeyData = decodedSecretKey.subarray(0, 32);
    if (!PrivateKey.isValid(privateKeyData, Curve.secp256k1)) {
      throw new Error("Invalid private key");
    }
    const privKey = PrivateKey.createWithData(privateKeyData);
    const privateKeyString = Base64.encode(privKey.data());

    return privateKeyString;
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

bitcoinTransferAction(toAddress, accountID, transferAmount, privateKeyHex, publicKey, tx_hash, utxoAmount, tx_output, format){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode(privateKeyHex);
    const utxoTxId = HexCoding.decode(tx_hash);
    const sscript = this.buildPayToFormat(format, publicKey);
    const outPoint = TW.Bitcoin.Proto.OutPoint.create({
      hash: utxoTxId,
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
      byteFee: 1,
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


bitcoinTransferActionSegwit(){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType,BitcoinSigHashType, PrivateKey, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode("5gaVs9eHYCTzj2Eh6rBobUf366Td2VBpbY8miEyGhZES");
    const utxoTxId = HexCoding.decode("9f535670aa3e4d08685d400e10787c8398e3218065dcdb0c65a0c2781663cee4");
    const sscript = this.buildPayToWeetnesPublicKeyHash("029edda5f611ca43d706eb774d53c64c16f2bb6bb4aa9566eaa5d5a594e91c5b4e");
    const outPoint = TW.Bitcoin.Proto.OutPoint.create({
      hash: utxoTxId,
      index: 11,
      sequence: 4294967295
    });
    const utxo = TW.Bitcoin.Proto.UnspentTransaction.create({
      outPoint: outPoint,
      amount: 159303,
      script: sscript
    });
    
    const input = TW.Bitcoin.Proto.SigningInput.create({
      hashType: BitcoinScript.hashTypeForCoin(CoinType.bitcoin),
      amount: 200,
      byteFee: 1,
      toAddress: "bc1qtstyjv5uyt5kcsy0ru4h8m6a67f0xa9jy8z3gx",
      changeAddress: "bc1q87tmwgwlwry2jhgy8fvflm05p2v2t7kc5ju843",
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
    return {output: output, input: input, hexEncodedOutput: hexEncodedOutput};
  } catch  (error) {
    console.error(JSON.stringify(error));
    return JSON.stringify({ error: error.message });
  }
}



bitcoinTransferActionP2PKH(){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType,BitcoinSigHashType, PrivateKey, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode("2bdMTkAzsEuctaVMf7s29EymVJeKxmuxFmkVtfUK9JtL");
    const utxoTxId = HexCoding.decode("d5e05558c5c79781b434d5d3d2f92ae723558e8e3799a79776015a441ecc919e");
    const sscript = this.buildPayToPublicKeyHash("02fc19124a543fd3fce4dc064b27caf5e8ddba74ec2d52de544f9bb9243b70043b");
    const outPoint = TW.Bitcoin.Proto.OutPoint.create({
      hash: utxoTxId,
      index: 1,
      sequence: 4294967295
    });
    const utxo = TW.Bitcoin.Proto.UnspentTransaction.create({
      outPoint: outPoint,
      amount: 123129,
      script: sscript
    });
    
    const input = TW.Bitcoin.Proto.SigningInput.create({
      hashType: BitcoinScript.hashTypeForCoin(CoinType.bitcoin),
      amount: 100,
      byteFee: 1,
      toAddress: "1M7tAxEhZA3kn76XBwQE8RWaEq74XQkwhE",
      changeAddress: "18M4Zkjousm1u2VTWGUXrvFFdrRhzyD3rK",
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
    return {output: output, input: encoded, hexEncodedOutput: hexEncodedOutput};
  } catch  (error) {
    console.error(JSON.stringify(error));
    return JSON.stringify({ error: error.message });
  }
}


}
