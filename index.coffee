express = require("express")
app = express()
path = require 'path'
months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]

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
    date = new Date Date.parse param

  if isNaN(date.getTime())
    unix = null
    natural = null
  else
    unix = Math.round(date.getTime() / 1000)
    natural = "#{months[date.getMonth()]} #{date.getDate()}, #{date.getFullYear()}"

  if req.query.response == "html"
    res.render "index.pug", { output: "<h2>Response</h2>Unix timestamp: #{unix}<br>Date: #{natural}" }
  else
    res.json unix: unix, natural: natural

app.listen port, ->
  console.log "Timestamp app listening on port #{port}!"
