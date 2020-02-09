import mailgun from 'mailgun-js'
import h from 'react-hyperscript'
import { Email, Item, Span, A, renderEmail } from 'react-html-email'

fieldLabels = {
  name: "Name"
  email: "Email address"
  phoneNumber: "Phone number"
  numCopies: "Number of copies"
  comment: "Comment"
}

B = (props)-> h Span, {fontWeight: 'bold', props...}

EmailTemplate = (props)->
  {title, data} = props

  {grandparentName,
  familyConnectionDescription,
  familyConnection, rest...} = data

  h Email, {title}, [
    h Item
    h Item, {align:"center"}, [
      h Span, {fontSize: 20}, [
        "Contact form response from "
        h A, {
          href: "https://westfair-publishers.org"
        }, "Westfair Publishers"
        ":"
      ]
    ]
    h Item
    Object.entries(rest).map ([k,v])->
      label = fieldLabels[k] or k
      h Item, [
        h B, label+": "
        h Span, "#{v}"
      ]
    h Item
    h Item, {align:"center"}, [
      h Span, {fontSize: 20}, [
        "Family connection"
      ]
    ]
    h Item, [
      h B, grandparentName
      h Span, " – #{familyConnection}"
    ]
    h Item, [
      h B, "More information: "
      h Span, familyConnectionDescription
    ]
  ]


api = mailgun {
  apiKey: process.env.API_KEY,
  domain: process.env.DOMAIN
}

sendMessage = (data)->
  new Promise (resolve, reject)->
    api.messages().send data, (error, body)->
      reject(error) if error
      resolve()

export default (req, res) =>
  res.setHeader('Content-Type', 'application/json')

  if req.method != 'POST'
    res.statusCode = 405
    res.end JSON.stringify({ success: false })
    return

  if not req.body? or req.body.length == 0
    res.statusCode = 400
    res.end JSON.stringify({success: false, error: "No request body"})
    return


  name = "Westfair Publishers contact from #{req.body.name}"
  email = h(EmailTemplate, {title:name, data: req.body})
  html = renderEmail email
  # Handle a successful request
  data = {
    from: process.env.EMAIL_FROM,
    to: process.env.EMAIL_TO,
    subject: name,
    html
  }

  try
    await sendMessage(data)
  catch error
    console.log(error)
    res.statusCode = 500
    res.end JSON.stringify({ success: false, error })
    return

  res.statusCode = 200
  res.end JSON.stringify({ success: true })
