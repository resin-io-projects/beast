_ = require('lodash')

fb = require("pitft")("/dev/fb1", true)
fb.clear()
xMax = fb.size().width
yMax = fb.size().height

snake = JSON.parse(process.env.RASTER_SNAKE)
index = _.indexOf(snake, process.env.RESIN_DEVICE_UUID)
columns = parseInt(process.env.RASTER_COLUMNS, 10)
column = index % columns
row = Math.floor(index / columns)

update = ->
  fb.color(1, 1, 1)
  fb.font("fantasy", 40)
  fb.text(xMax/2, yMax/2, "(#{column}, #{row})", true)
  fb.circle(0, 0, 10)
  fb.blit()

setInterval(update, 1000)