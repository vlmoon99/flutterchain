import * as xrpl from "xrpl";
const { encode, encodeForSigning, setTransactionFlagsToNumber } = xrpl;
import * as Signature from "elliptic/lib/elliptic/ec/signature";
import BN from "bn.js";

export class XRPUtils {
  async createUnsignedTransaction(txInJson) {
    let unsignedTx = JSON.parse(txInJson);
    setTransactionFlagsToNumber(unsignedTx);

    // encode for signing and take truncated sha512 hash as payload
    const encodedForSigning = encodeForSigning(unsignedTx);

    const hashUnsigned = await crypto.subtle.digest(
      "SHA-512",
      Buffer.from(encodedForSigning, "hex")
    );
    const payload = new Uint8Array(hashUnsigned.slice(0, 32));
    return JSON.stringify({ payload, unsignedTx });
  }

  signTransactionWithMPCSignature(unsignedTx, signatureData) {
    unsignedTx = JSON.parse(unsignedTx);

    const { big_r, big_s } = JSON.parse(signatureData);

    const sigBuffer = {
      r: new BN(Buffer.from(big_r.slice(2), "hex")),
      s: new BN(Buffer.from(big_s, "hex")),
    };

    const signature = Signature.default.prototype.toDER.call(sigBuffer);
    unsignedTx.TxnSignature = Buffer.from(signature).toString("hex");

    const serializedSignedTx = encode(unsignedTx);

    return serializedSignedTx;
  }
}
