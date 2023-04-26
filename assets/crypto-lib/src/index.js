import { initWasm, TW } from "@trustwallet/wallet-core";
import { NearBlockchain } from "./chains/near_blockchain";
import { generateMnemonic } from "./core/mnemonic";

initWasm().then((WalletCore) => {
  //First step add WalletCore and TW to window
  window.WalletCore = WalletCore;
  window.TW = TW;
  //End

  //Second Step add blockchains classes to window
  window.NearBlockchain = new NearBlockchain();
  //End

  //Third Step add core functions to window
  window.generateMnemonic = generateMnemonic;
  //End

  console.log("Flutterchain lib initialized");
});
