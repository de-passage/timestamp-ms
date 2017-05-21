express = require("express")
app = express()
path = require 'path'

port = process.argv[2] or 8000

app.set 'views', path.join __dirname, '/views'
app.set 'view engine', 'pug'

app.use('/static', express.static('public'))

app.get "/", (req, res) ->
  res.render "index.pug"

app.get "/:date", (req, res) ->
  param = req.params.date
  ts = parseInt(param)
  if !isNaN(ts)
    date = new Date(ts * 1000)
  else
    date = new Date param

  if isNaN(date.getTime())
    unix = null
    natural = null
  else
    unix = Math.round(date.getTime() / 1000)
    natural = date.toDateString()

  if req.query.response == "html"
    res.render "index.pug", { output: "#{unix}: #{natural}" }
  else
    res.json unix: unix, natural: natural

app.listen port, ->
  console.log "Timestamp app listening on port #{port}!"
