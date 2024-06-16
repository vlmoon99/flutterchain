import { initWasm, TW } from "@trustwallet/wallet-core";
import { NearBlockchain } from "./chains/near_blockchain";
import { BitcoinBlockchain } from "./chains/btc_blockhain";
import { generateMnemonic } from "./core/mnemonic";
import * as bitcoin from 'bitcoinjs-lib';
import { generateAddressForNearMPC } from "./utils/kdf";
import { EVMUtils } from "./utils/evm";
import { BitcoinUtils } from "./utils/bitcoin";
import { XRPUtils } from "./utils/xrp";

initWasm().then((WalletCore) => {
  //First step add WalletCore and TW to window
  window.WalletCore = WalletCore;
  window.TW = TW;
  //End

  //Second Step add blockchains classes to window
  window.NearBlockchain = new NearBlockchain();
  window.BitcoinBlockchain = new BitcoinBlockchain();
  window.EVMUtils = new EVMUtils();
  window.BitcoinUtils = new BitcoinUtils();
  window.XRPUtils = new XRPUtils();
  //End
  
  //Third Step add core functions to window
  window.generateMnemonic = generateMnemonic;
  window.generateAddressForNearMPC = generateAddressForNearMPC;
  //End

  console.log("Flutterchain lib initialized");
});
