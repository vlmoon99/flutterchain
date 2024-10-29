import { initWasm, TW } from "@trustwallet/wallet-core";
import { NearBlockchain } from "./chains/near_blockchain";
import { BitcoinBlockchain } from "./chains/btc_blockhain";
import { generateMnemonic } from "./core/mnemonic";


initWasm().then((WalletCore) => {

  window.WalletCore = WalletCore;
  window.TW = TW;
  
  window.NearBlockchain = new NearBlockchain();
  window.BitcoinBlockchain = new BitcoinBlockchain();
  window.generateMnemonic = generateMnemonic;

  console.log("Flutterchain lib initialized");
});
