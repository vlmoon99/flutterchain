import * as fs from 'node:fs';

const filePath = './node_modules/@trustwallet/wallet-core/dist/src/keystore/fs-storage.js';
const searchString = 'fs/promises';
const replacementString = 'fs';

fs.readFile(filePath, 'utf-8', (err, data) => {
  if (err) {
    console.error('File read error:', err);
    return;
  }

  const updatedData = data.replace(searchString, replacementString);

  fs.writeFile(filePath, updatedData, 'utf-8', (err) => {
    if (err) {
      console.error('File write error:', err);
    } else {
      console.log('WalletCore fix applied.');
    }
  });
});
