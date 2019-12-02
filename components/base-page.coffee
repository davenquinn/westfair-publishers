import h from '@macrostrat/hyper'
import {Helmet} from 'react-helmet'
import styles from './main.styl'

BasePage = (props)->
  {children, rest...} = props
  h 'div.page', rest, [
    h Helmet, [
      <meta charset="utf-8" />
      <title>Westfair Publishers — Always With Spirit</title>
    ]
    children
  ]

HTMLPage = (props)->
  {html, rest...} = props
  h BasePage, rest, [
    h 'div.content', {dangerouslySetInnerHTML: {__html: html}}
  ]

export {BasePage, HTMLPage}
