const withCSS = require('@zeit/next-css');
const withStylus = require('@zeit/next-stylus');
const withMDX = require('@next/mdx');
const withCoffeescript = require('next-coffeescript');

const cfg = {
  cssModules: true
};

module.exports = withCoffeescript(withCSS(withStylus(cfg)));
