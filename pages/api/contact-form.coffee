export default (req, res) =>
  console.log(req.body)
  res.setHeader('Content-Type', 'application/json')

  if req.method != 'POST'
    res.statusCode = 405
    res.end JSON.stringify({ success: false })

  res.statusCode = 200
  res.end JSON.stringify({ success: true })
