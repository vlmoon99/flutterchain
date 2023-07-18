export function generateMnemonic(passphrase) {
  const { HDWallet } = window.WalletCore;
  const wallet = HDWallet.create(128, passphrase || "");

  return JSON.stringify({
    mnemonic: wallet.mnemonic(),
    passphrase: passphrase,
  });
}
