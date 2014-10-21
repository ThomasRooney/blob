levels = require './levels'
uid = require("uid")

module.exports = class Player
  constructor: (@socket) ->
    @x = 0
    @y = 0
    @level = 0
    @connections = []
    @id = uid()
    console.log "New Player[#{@id}]"
  connect: (player) ->
    @connections.append (player)
  setLevel: (i) ->
    @socket.emit('world', levels[i])