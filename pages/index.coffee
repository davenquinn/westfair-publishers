import h from '@macrostrat/hyper'
import {readFileSync} from 'fs'
import {resolve} from 'path'

pageContent = readFileSync(resolve(__dirname, "../content/index.html"))

IndexPage = ->
  h "div", {dangerouslySetInnerHTML: {__html: pageContent}}

export default IndexPage
