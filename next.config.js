const withCSS = require('@zeit/next-css');
const withStylus = require('@zeit/next-stylus');
const withMDX = require('@next/mdx')();
const withCoffeescript = require('next-coffeescript');

// For production our env vars should be provided by ZEIT NOW
if (process.env.NODE_ENV == 'development') {
  const nowCfg = require('./now.json');
  require("dotenv").config()
}

// Assemble environment from process environment
const keys = Object.keys(nowCfg.env)
env = Object.fromEntries(keys.map(k=> [k, process.env[k]]));

const baseCfg = {
  cssModules: true,
  cssLoaderOptions: {
    importLoaders: 1,
    localIdentName: "[local]___[hash:base64:5]",
  },
  pageExtensions:  ['js', 'jsx', 'mdx','coffee'],
  env
};

console.log(baseCfg)

module.exports = withCoffeescript(
  withCSS(withStylus(withMDX(baseCfg))));
