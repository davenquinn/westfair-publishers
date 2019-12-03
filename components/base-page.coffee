import h from '../styles'
import {Helmet} from 'react-helmet'
import {SiteTitle, Nav} from './nav'
import Footer from './footer.mdx'

BasePage = (props)->
  {children, rest...} = props
  h 'div.page', rest, [
    h Helmet, [
      <meta charset="utf-8" />
      <title>Westfair Publishers — Always With Spirit</title>
      <link href="https://fonts.googleapis.com/css?family=EB+Garamond&display=swap" rel="stylesheet" />
    ]
    h 'div.wrap', [
      h 'header', [
        h SiteTitle, "Always With Spirit"
        h Nav
      ]
      h 'div.main', [
        children
      ]
      h Footer
    ]
  ]

HTMLPage = (props)->
  {html, rest...} = props
  h BasePage, rest, [
    h 'div.content', {dangerouslySetInnerHTML: {__html: html}}
  ]

export {BasePage, HTMLPage}

