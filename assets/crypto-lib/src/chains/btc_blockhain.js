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


  // getAdressBTCFromHexPublicKeyDescription(publicKeyHEX){
  //   const { BitcoinAddress, HexCoding, PublicKey, PublicKeyType} = window.WalletCore;
  //   const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
  //   const adressBTC = BitcoinAddress.createWithPublicKey(publicKeyDecode, 0x6f);
  //   return adressBTC.keyhash();
  // }

  getAdressBTCFromHexPublicKeyMain(publicKeyHEX, needKeyHash){
    const { BitcoinAddress, HexCoding, PublicKey, PublicKeyType} = window.WalletCore;
    const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
    const adressBTC = BitcoinAddress.createWithPublicKey(publicKeyDecode, 0x00);
    if (needKeyHash){
      return adressBTC.keyhash();
    } else {
      return adressBTC.description();
    }
  }

  // getAdressBTCFromHexPublicKeyDescription1(publicKeyHEX){
  //   const { BitcoinAddress, HexCoding, PublicKey, PublicKeyType} = window.WalletCore;
  //   const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
  //   const adressBTC = BitcoinAddress.createWithPublicKey(publicKeyDecode, 0x6f);
  //   const hexString = HexCoding.encode(adressBTC.keyhash());
  //   return hexString;
  // }


 

// getBlockChainDataFromMnemonicTest(
//   mnemonic,
//   passphrase = "",
//   account = "0'",
//   change = "0'",
//   address = "0'"
// ) {
//   const { CoinType, HDWallet, HexCoding, BitcoinAddress } = window.WalletCore;
//   const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
//   const derivationPath = `m/44'/1'/${account}/${change}/${address}`;
//   const privateKey = wallet.getKey(CoinType.bitcoin, derivationPath);
//   // const AddressBTC = wallet.getAddressForCoin(CoinType.bitcoin) for SegWit mainnet
//   const privateKeyString = bs58.encode(privateKey.data());
//   const publicKey = privateKey.getPublicKeySecp256k1(true);
//   const adressBTC = BitcoinAddress.createWithPublicKey(publicKey, 0x6f);
//   return JSON.stringify({
//     mnemonic: wallet.mnemonic(),
//     publicKey: publicKey.description(),
//     accountId: adressBTC.description(),
//     privateKey: privateKeyString,
//     passphrase: passphrase,
//     derivationPath: {
//       purpose: "44'",
//       coinType: "0'",
//       accountNumber: account,
//       change: change,
//       address: address,
//     },
//   });
// }

getBlockChainDataFromMnemonic(
  mnemonic,
  passphrase = "",
  account = "0'",
  change = "0'",
  address = "0'"
) {
  const { CoinType, HDWallet, HexCoding, BitcoinAddress } = window.WalletCore;
  const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
  const derivationPath = `m/44'/0'/${account}/${change}/${address}`;
  const privateKey = wallet.getKey(CoinType.bitcoin, derivationPath);
  const AddressBTC = wallet.getAddressForCoin(CoinType.bitcoin) //for SegWit mainnet
  const privateKeyString = bs58.encode(privateKey.data());
  const publicKey = privateKey.getPublicKeySecp256k1(true);
  const adressBTC = BitcoinAddress.createWithPublicKey(publicKey, 0x00);
  return JSON.stringify({
    mnemonic: wallet.mnemonic(),
    publicKey: publicKey.description(),
    accountId: AddressBTC,
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

// buildPayToPublicKey(publicKeyHEX){
//   const { BitcoinScript, BitcoinAddress,HexCoding, PublicKey, PublicKeyType, CoinType} = window.WalletCore;
//     const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
//     // const adressBTC = BitcoinAddress.createWithPublicKey(publicKeyDecode, 0x6f);
//     // const res =  BitcoinScript.buildPayToPublicKeyHash(publicKeyDecode.data());
//     const res =  BitcoinScript.buildPayToPublicKey(publicKeyDecode.data()).data();
//     const hexString = HexCoding.encode(res);
//     const Stringhex = HexCoding.decode(hexString.substring(2));
//     return hexString;
// }

// buildPayToPublicKeyHash1(publicKeyHEX){
//   const { BitcoinScript,HexCoding, PublicKey, PublicKeyType, Hash} = window.WalletCore;
//   const publicKeyData = HexCoding.decode(publicKeyHEX);
//   const utxoPubkeyHash = Hash.ripemd(Hash.sha256(publicKeyData));
//   const test = this.getAdressBTCFromHexPublicKeyDescription1(publicKeyHEX);
//   // const utxoPubkeyHash = this.getAdressBTCFromHexPublicKeyDescription1(publicKeyHEX);
//   // const res = BitcoinScript.buildPayToPublicKeyHash(utxoPubkeyHash);
//   const hexString = HexCoding.encode(utxoPubkeyHash);
//   // const Stringhex = HexCoding.decode(hexString.substring(2));
//   if (test == hexString){
//     return {hexString:hexString, test: test };    
//   }
//   return  test;
// }


// buildPayToPublicKeyHashTest(publicKeyHEX){
//   const { BitcoinScript,HexCoding, PublicKey, PublicKeyType, Hash} = window.WalletCore;
//     const utxoPubkeyHash = this.getAdressBTCFromHexPublicKeyDescription(publicKeyHEX);
//     const buildPayToPublicKeyHash = BitcoinScript.buildPayToPublicKeyHash(utxoPubkeyHash);
    
//     return buildPayToPublicKeyHash.data();
// }

buildPayToPublicKeyHash(publicKeyHEX){
  const { BitcoinScript } = window.WalletCore;
  const needKeyHash = true;
  const utxoPubkeyHash = this.getAdressBTCFromHexPublicKeyMain(publicKeyHEX, needKeyHash);
  const buildPayToPublicKeyHash = BitcoinScript.buildPayToPublicKeyHash(utxoPubkeyHash);
    
  return buildPayToPublicKeyHash.data();
}

// buildPayToWeetnesPublicKeyHash(publicKeyHEX){
//   const { BitcoinScript, CoinType, HexCoding } = window.WalletCore;
//   const buildPayToWeetnesPublicKeyHash = BitcoinScript.lockScriptForAddress(publicKeyHEX, CoinType.bitcoin);
//   // const stringHex = HexCoding.encode(buildPayToWeetnesPublicKeyHash.data());
//   return buildPayToWeetnesPublicKeyHash.data();
// }
buildPayToWeetnesPublicKeyHash(publicKeyHEX){
  const { BitcoinScript, CoinType, HexCoding, Hash } = window.WalletCore;
  const hexString = HexCoding.decode(publicKeyHEX);
  const heash = Hash.ripemd(Hash.sha256(hexString));
  const buildPayToWeetnesPublicKeyHash = BitcoinScript.buildPayToWitnessPubkeyHash(heash);

  return buildPayToWeetnesPublicKeyHash.data();
}

// buildPayToPublicKeyHash2(publicKeyHEX){
//   const { BitcoinScript,HexCoding, PublicKey, PublicKeyType, Hash, CoinType} = window.WalletCore;
//   const utxoTxId = HexCoding.decode("d5e05558c5c79781b434d5d3d2f92ae723558e8e3799a79776015a441ecc919e");
//   const res = BitcoinScript.lockScriptForAddress(publicKeyHEX, CoinType.bitcoin, utxoTxId, 2584897)
//     // const Stringhex = HexCoding.decode(hexString.substring(2));
//     return res.data();
// }
// buildPayToPublicKeyHash1(publicKeyHEX){
//   const { BitcoinScript,HexCoding, PublicKey, PublicKeyType, Hash} = window.WalletCore;
//     const publicKeyDecode = PublicKey.createWithData(HexCoding.decode(`0x${publicKeyHEX}`), PublicKeyType.secp256k1);
//     const utxoPubkeyHash = Hash.ripemd(Hash.sha256(publicKeyDecode.data()));
//     const res =  BitcoinScript.buildPayToPublicKeyHash(utxoPubkeyHash);
//     const hexString = HexCoding.encode(res.data());
//     // const Stringhex = HexCoding.decode(hexString.substring(2));
//     return hexString;
// }
// test(){
//   const { BitcoinScript,HexCoding, PublicKey, PublicKeyType, Hash, CoinType, CoinTypeConfiguration} = window.WalletCore;
//   const test = CoinTypeConfiguration.getAccountURL(CoinType.bitcoin, 'myiZPoDRUWYUitxefEfdzuGByK1sgXEtmy');
//   return test
// }


// bitcoinTransferActionTest(){
//   try{
//     const { TW, WalletCore } = window;
//     const { AnySigner, CoinType,BitcoinSigHashType, PrivateKey, BitcoinScript, HexCoding } = WalletCore;
//     const privateKey = bs58.decode("4gBSAXzSHcYwQukjcYByVrNfGGRG2e7rB3Pbhasq5FEm");
//     const utxoTxId = HexCoding.decode("d5e05558c5c79781b434d5d3d2f92ae723558e8e3799a79776015a441ecc919e");
//     const sscript = this.buildPayToPublicKeyHashTest("03ddd1b0e324f9807465a277c99516eaf4f9de636e71352132253d658233fa53df");
//     const scriptsHexPubkeyHash = HexCoding.encode(this.getAdressBTCFromHexPublicKeyDescription('03ddd1b0e324f9807465a277c99516eaf4f9de636e71352132253d658233fa53df'));
//     const outPoint = TW.Bitcoin.Proto.OutPoint.create({
//       hash: utxoTxId.reverse(),
//       index: 1,
//       sequence: 4294967295
//     });
//     const utxo = TW.Bitcoin.Proto.UnspentTransaction.create({
//       outPoint: outPoint,
//       amount: 123129,
//       script: sscript
//     });
    
//     const input = TW.Bitcoin.Proto.SigningInput.create({
//       hashType: BitcoinSigHashType.all,
//       // hashType: BitcoinSigHashType.all,
//       amount: 100,
//       // extraOutputs:[{toAddress: "mkYhgBSZocDy9CkAiFz1p15oX9mA5kiHYf",amount: 100,}],
//       byteFee: 1,
//       toAddress: "mkYhgBSZocDy9CkAiFz1p15oX9mA5kiHYf",
//       changeAddress: "myiZPoDRUWYUitxefEfdzuGByK1sgXEtmy",
//       // extraOutputs: [{toAddress: "mkYhgBSZocDy9CkAiFz1p15oX9mA5kiHYf",amount: 100,}],
//       utxo: [utxo],
//       privateKey: [Uint8Array.from(privateKey)],
//     });
//     // input.scripts[scriptsHexPubkeyHash] = sscript;

//     const encodedForPlan = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
//     const outputDataForPlan = AnySigner.plan(encodedForPlan, CoinType.bitcoin);
//     const outputForPlan = TW.Bitcoin.Proto.TransactionPlan.decode(outputDataForPlan);
//     input.plan = outputForPlan;
    
//     const encoded = TW.Bitcoin.Proto.SigningInput.encode(input).finish();
//     const outputData = AnySigner.sign(encoded, CoinType.bitcoin);
//     const output = TW.Bitcoin.Proto.SigningOutput.decode(outputData);
//     // const output = TW.Bitcoin.Proto.SigningOutput.decode(outputData);
//     // if (output.error != 0){
//     //   return output.error
//     // }
//     return {output: output, input: encoded};
//   } catch  (error) {
//     console.error(JSON.stringify(error));
//     return JSON.stringify({ error: error.message });
//   }
// }



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
    const privateKey = bs58.decode("Dn7cpHCdfxDbZJQxGnSspyCYJXGQCfgG1tqmKu5vBJcn");
    const utxoTxId = HexCoding.decode("9f535670aa3e4d08685d400e10787c8398e3218065dcdb0c65a0c2781663cee4");
    const sscript = this.buildPayToWeetnesPublicKeyHash("037753c5c37bf5626364f653d5b5d8f16c21105afc06da20957f68894670c2b74e");
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
    // if (output.error != 0){
    //   return output.error
    // }
    const hexEncodedOutput = HexCoding.encode(output.encoded);
    return {output: output, input: input, hexEncodedOutput: hexEncodedOutput};
  } catch  (error) {
    console.error(JSON.stringify(error));
    return JSON.stringify({ error: error.message });
  }
}



bitcoinTransferAction1(){
  try{
    const { TW, WalletCore } = window;
    const { AnySigner, CoinType,BitcoinSigHashType, PrivateKey, BitcoinScript, HexCoding } = WalletCore;
    const privateKey = bs58.decode("519BNZPMhDKAerUbV8ZLmAZuyoAbkhhj5de1xpHMLd1i");
    const utxoTxId = HexCoding.decode("d5e05558c5c79781b434d5d3d2f92ae723558e8e3799a79776015a441ecc919e");
    const sscript = this.buildPayToPublicKeyHash("032a3b57efef66ffc9a9017db7fa99ea97c9465785ef7be9a3c207d0ef7ecef98d");
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
      changeAddress: "1Ky1s8gqoToKJqAHHU1xgMcHdXQwm5kqgP",
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
