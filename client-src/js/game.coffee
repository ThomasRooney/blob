
App =
  start: ->
    @connect()
    console.log "app started!"
  connect: ->
    @socket = io('http://localhost/')
    @socket.on 'connect', =>
      @socket.on('world', (world) -> console.log world)
      @socket.on('disconnect', (d) -> console.log d)


module.exports = App
