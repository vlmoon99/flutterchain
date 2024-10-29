import { defineConfig } from "vite";
import babel from "vite-plugin-babel";
import { nodePolyfills } from "vite-plugin-node-polyfills";
import WebWorkerPlugin from "vite-plugin-webworker-service";
import topLevelAwait from "vite-plugin-top-level-await";
import wasm from "vite-plugin-wasm";
import { viteStaticCopy } from 'vite-plugin-static-copy'

export default defineConfig({
  base: "./",
  plugins: [
    babel(),
    nodePolyfills(),
    WebWorkerPlugin(),
    wasm(),
    topLevelAwait(),
    //requires main lib
    viteStaticCopy({
      targets: [
        {
          src: 'node_modules/@trustwallet/wallet-core/dist/lib/wallet-core.wasm',
          dest: ''
        }
      ]
    })
  ],
  build: {
    rollupOptions: {
      output: {
        entryFileNames: "bundle.js",
        chunkFileNames: "bundle.js",
        assetFileNames: "[name][extname]",
      }
    },
  },
  server: {
    open: "/index.html",
    port: 3000,
  },
  resolve: {
    alias: {
      "@concordium/rust-bindings": "@concordium/rust-bindings/bundler", // Resolve bundler-specific wasm entrypoints for concordium
    },
  }
});
