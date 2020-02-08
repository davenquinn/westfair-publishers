import mailgun from 'mailgun-js'
import { Email, Item, Span, A, renderEmail } from 'react-html-email'

EmailTemplate = (props)->
  {title, data} = props
  <Email title={title}>
    <Item align="center">
      <Span fontSize={20}>
        Contact form response from
        <A href={process.env.DOMAIN}>Westfair Publishers</A>:
      </Span>
    </Item>
    {data.items().map (d)->
      <Item>{d[0]}: {d[1]}</Item>
    }
  </Email>


api = mailgun {
  apiKey: process.env.API_KEY,
  domain: process.env.DOMAIN
}

sendMessage = (data)->
  new Promise (resolve, reject)->
    api.messages().send data, (error, body)->
      reject(error) if error?
      resolve()

export default (req, res) =>
  console.log(req.body)
  res.setHeader('Content-Type', 'application/json')

  if req.method != 'POST'
    res.statusCode = 405
    res.end JSON.stringify({ success: false })

  name = "Westfair Publishers contact from #{props.name}"
  html = renderEmail {title: name, data: req.body}

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
    res.statusCode = 500
    res.end JSON.stringify({ success: false, error })

  res.statusCode = 200
  res.end JSON.stringify({ success: true })
