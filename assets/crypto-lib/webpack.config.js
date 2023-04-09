const path = require("path");
const NodePolyfillPlugin = require("node-polyfill-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

const config = {
  entry: "./src/index.js",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
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
