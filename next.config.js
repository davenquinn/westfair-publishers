const withCSS = require('@zeit/next-css');
const withStylus = require('@zeit/next-stylus');
const withMDX = require('@next/mdx')();
const withCoffeescript = require('next-coffeescript');

let env = null
// For production our env vars should be provided by ZEIT NOW

let baseCfg = {
  cssModules: true,
  cssLoaderOptions: {
    importLoaders: 1,
    localIdentName: "[local]___[hash:base64:5]",
  },
  pageExtensions:  ['js', 'jsx', 'mdx','coffee'],
};

if (process.env.NODE_ENV == 'development') {
  require("dotenv").config()
  // Assemble environment from process environment
  const keys = ["API_KEY", "DOMAIN", "EMAIL_TO", "EMAIL_FROM"]
  baseCfg.env = Object.fromEntries(keys.map(k=> [k, process.env[k]]));
}

console.log(baseCfg)

module.exports = withCoffeescript(
  withCSS(withStylus(withMDX(baseCfg))));
