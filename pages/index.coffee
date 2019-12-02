import h from '@macrostrat/hyper'
import {readFileSync} from 'fs'
import {resolve} from 'path'
import BasePage from '../components/base-page'

pageContent = readFileSync(resolve(__dirname, "../content/index.html"))

IndexPage = ->
  h BasePage, [
    h 'div.content', {dangerouslySetInnerHTML: {__html: pageContent}}
  ]

export default IndexPage
