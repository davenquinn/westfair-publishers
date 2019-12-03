import h from '../styles'
import {useState} from 'react'

HolidayMessage = ->
  [isShown,setShown] = useState(true)

  onClick = ->
    setShown(not isShown)

  style = {display: 'block'}
  if not isShown
    style = {display: 'none'}

  <>
    <a class="button show-hide-button" onClick={onClick}>{
      if isShown then "Hide holiday message" else "Show holiday message"
    }</a>
    <div class="holiday-message" style={style}>
      <div class="message-body">
        <div class="image-container">
          <img class="_idGenObjectAttribute-1" src="/assets/red-christmas-parcel-sm.png" alt="" />
        </div>
        <p class="caption">
        Open and unwrap layer by layer this amazing one-of-kind gift, to reveal
        profiles of direct forebears in past centuries of your family history.
        </p>
      </div>
    </div>
  </>
export {HolidayMessage}
