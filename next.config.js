const withCSS = require('@zeit/next-css');
const withStylus = require('@zeit/next-stylus');
const withMDX = require('@next/mdx')();
const withCoffeescript = require('next-coffeescript');

const baseCfg = {
  cssModules: true,
  cssLoaderOptions: {
    importLoaders: 1,
    localIdentName: "[local]___[hash:base64:5]",
  },
  pageExtensions:  ['js', 'jsx', 'mdx','coffee']
};

module.exports = withCoffeescript(
  withCSS(withStylus(withMDX(baseCfg))));

