_ = require('lodash')
moment = require('moment')
radians = require('degrees-radians')

fb = require("pitft")("/dev/fb1", true)
fb.clear()
xResolution = fb.size().width
yResolution = fb.size().height

snake = JSON.parse(process.env.RASTER_SNAKE)
index = _.indexOf(snake, process.env.RESIN_DEVICE_UUID)
columns = parseInt(process.env.RASTER_COLUMNS, 10)
rows = snake.length / columns
column = index % columns
row = Math.floor(index / columns)

totalX = xResolution * columns
totalY = yResolution * rows

RA = 180/Math.PI

update = ->
  rightNow = moment()
  secondsAngle = rightNow.seconds()*6
  deltaX = Math.sin(radians(secondsAngle)) * xResolution / 2
  deltaY = Math.cos(radians(secondsAngle)) * yResolution / 2
  originX = xResolution / 2
  originY = yResolution / 2
  locationX = originX + deltaX
  locationY = originY + deltaY
  relativeOriginX = originX - (row * xResolution)
  relativeOriginY = originY - (column * yResolution)
  relativeLocationX = locationX - (row * xResolution)
  relativeLocationY = locationY - (column * yResolution)

  fb.clear()
  fb.color(1, 1, 1)
  fb.line(relativeOriginX, relativeOriginY, relativeLocationX, relativeLocationY, 10)
  fb.blit()

setInterval(update, 100)