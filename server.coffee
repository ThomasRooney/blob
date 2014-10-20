finalhandler = require('finalhandler')
connect = require("connect")
serveStatic = require('serve-static')
http = require("http")

initial_world:
  id: 0
  level: [
    {
      type: 1
      text: "Hello World"
      x: 0
      y: 0
    }
  ]

serve = serveStatic('public/', {'index': ['index.html', 'index.htm']})

server = http.createServer (req, res) ->
  done = finalhandler(req, res)
  serve(req, res, done)



io = require('socket.io')(server)

data = [
    {
      id: 0
      level: [
        {
          type: 1
          text: "Hello World"
          x: 0
          y: 0
        }
      ]
      players: []
    }
  ]

num_players = 0

io.on 'connection', (socket) ->
  console.log "player connected"
  players += 1
  player =
    id: uid 10
    position: initial_world.spawn
  data[0].players.append player
  socket.emit('world', initial_world)
  socket.on 'l', ({x, y}) ->
    player.position = {x,y}
    for p in player.level.players
      if p != player
        p.emit "l", {x,y}


#create node.js http server and listen on port
server.listen 8080
