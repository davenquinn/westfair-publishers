const withCSS = require('@zeit/next-css');
const withStylus = require('@zeit/next-stylus');
const withMDX = require('@next/mdx')();
const withCoffeescript = require('next-coffeescript');

let cfg = withCoffeescript(
  withCSS(withStylus(withMDX({cssModules: true}))));
cfg.pageExtensions =  ['js', 'jsx', 'mdx','coffee'];

module.exports = cfg;
