Player = require './player'
levels = require './levels'

module.exports = class Controller
  constructor: ->
    @players = []
  newPlayer: (socket) ->
    player = new Player(socket)
    console.log "player connected"
    @players += player
    player.setLevel(0)
    socket.on 'l', ({x, y}) ->
      player.position = {x,y}
      for p in player.level.players
        if p != player
          p.emit "l", {x,y}