import h from '@macrostrat/hyper'
import {Helmet} from 'react-helmet'

BasePage = (props)->
  {children, rest...} = props
  h 'div.page', rest, [
    h Helmet, [
      <meta charset="utf-8" />
      <title>Westfair Publishers — Always With Spirit</title>
      <link href="/assets/idGeneratedStyles.css" rel="stylesheet" type="text/css" />
    ]
    children
  ]

export default BasePage
