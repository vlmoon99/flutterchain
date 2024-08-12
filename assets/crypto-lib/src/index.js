import "core-js/features";
import { generateAddressForNearMPC } from "./utils/kdf";
import { EVMUtils } from "./utils/evm";
import { BitcoinUtils } from "./utils/bitcoin";
import { XRPUtils } from "./utils/xrp";
import { ConcordiumBlockchain } from "./chains/concordium_blockchain";

window.ConcordiumBlockchain = new ConcordiumBlockchain();
window.EVMUtils = new EVMUtils();
window.BitcoinUtils = new BitcoinUtils();
window.XRPUtils = new XRPUtils();
window.generateAddressForNearMPC = generateAddressForNearMPC;
