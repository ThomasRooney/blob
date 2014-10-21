finalhandler = require('finalhandler')
connect = require("connect")
serveStatic = require('serve-static')
http = require("http")

Controller = require './controller'
port = 8080

serve = serveStatic('public/', {'index': ['index.html', 'index.htm']})

server = http.createServer (req, res) ->
  done = finalhandler(req, res)
  serve(req, res, done)

io = require('socket.io')(server)

controller = new Controller

io.on 'connection', (socket) ->
  controller.newPlayer(socket)

#create node.js http server and listen on port

console.log "Listening on port #{port}"

server.listen port
