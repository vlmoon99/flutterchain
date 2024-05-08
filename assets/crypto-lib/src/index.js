import { initWasm, TW } from "@trustwallet/wallet-core";
import { NearBlockchain } from "./chains/near_blockchain";
import { BitcoinBlockchain } from "./chains/btc_blockhain";
import { generateMnemonic } from "./core/mnemonic";

initWasm().then((WalletCore) => {
  //First step add WalletCore and TW to window
  window.WalletCore = WalletCore;
  window.TW = TW;
  //End

  //Second Step add blockchains classes to window
  window.NearBlockchain = new NearBlockchain();
  window.BitcoinBlockchain = new BitcoinBlockchain();
  //End

  //Third Step add core functions to window
  window.generateMnemonic = generateMnemonic;
  //End

  console.log("Flutterchain lib initialized");
});
