import h from '@macrostrat/hyper'
import {readFileSync} from 'fs'
import {resolve} from 'path'
import {HTMLPage} from '../components/base-page'

pageContent = readFileSync(resolve(__dirname, "../content/index.html"))

IndexPage = ->
  h HTMLPage, {html: pageContent}

export default IndexPage
