-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")

  constants = {}

  constants.scale = {}
  constants.scale.walk = 150
  constants.scale.work = 70
  constants.scale.clock = 1

  constants.eat = 0.25
  constants.max_progress = 100
  constants.homeless_need = 50

  constants.font = {}
  constants.font.filename = "fonts/Inconsolata-Bold.ttf"
  constants.font.normal = 22
  constants.font.small = 14

  constants.time = {}
  constants.time.start   =  480 --  8:00am
  constants.time.lunch   =  660 -- 11:00am
  constants.time.prepare =  780 --  1:00pm
  constants.time.dinner  =  960 --  4:00pm
  constants.time.cleanup = 1080 --  6:00pm
  constants.time.close   = 1200 --  8:00pm

  constants.money = {}
  constants.money.initial = 1000
  constants.money.wage = 50

  constants.coords = {}
  constants.coords.start = Coordinate.new(5, 11)
  constants.coords.entrance = Coordinate.new(1, 9)
  constants.coords.exit = Coordinate.new(1, 3)
  
  constants.sizes = {}
  constants.sizes.square = 64
  constants.sizes.pawn = 32
  constants.sizes.map = {w=12, h=12}
end
