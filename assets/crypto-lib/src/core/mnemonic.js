export function generateMnemonic(strength = 128) {
  strength = parseInt(strength);
  const { HDWallet } = window.WalletCore;
  const wallet = HDWallet.create(strength, "");

  return JSON.stringify({
    mnemonic: wallet.mnemonic(),
  });
}
