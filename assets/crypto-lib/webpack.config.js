const path = require("path");
const NodePolyfillPlugin = require("node-polyfill-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

const config = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
    libraryTarget: "commonjs2",
  },
  target: "node",
  module: {
    rules: [
      {
        parser: {
          // commonjs: false, // disable CommonJS
          // system: false, // disable SystemJS
          // harmony: false, // disable ES2015 Harmony import/export
          // requireInclude: false, // disable require.include
          // requireEnsure: false, // disable require.ensure
          // requireContext: true, // disable require.context
          // browserify: true, // disable special handling of Browserify bundles
          // requireJs: true, // disable requirejs.*
          node: true, // disable __dirname, __filename, module, require.extensions, require.main, etc.
          // commonjsMagicComments: false, // disable magic comments support for CommonJS
          // node: {}, // reconfigure node layer on module level
          // worker: ["default from web-worker", "..."], // Customize the WebWorker handling for javascript files, "..." refers to the defaults.
        },
      },
    ],
  },
  plugins: [
    new NodePolyfillPlugin({
      excludeAliases: ["console"],
    }),
    new CopyWebpackPlugin({
      patterns: [{ from: "static", to: "" }],
    }),
  ],
};

module.exports = config;
