-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")
  local fast = 3

  constants = {}

  constants.scale = {}
  constants.scale.walk = 150
  constants.scale.work = 70
  constants.scale.clock = 1.25

  if fast then
    constants.scale.walk = constants.scale.walk * fast
    constants.scale.work = constants.scale.work * fast
    constants.scale.clock = constants.scale.clock * fast
  end

  constants.squelch = 0.25
  constants.max_progress = 100
  constants.breakfast_end = 2

  constants.trash = {}
  constants.trash.max = 50
  constants.trash.food_scale = 0.5


  constants.demand = {}
  constants.demand.initial = 40
  constants.demand.breakfast = .40
  constants.demand.lunch = .75
  constants.demand.dinner = 1.1

  constants.stock = {}
  constants.stock.start = {}
  constants.stock.start.core = 2
  constants.stock.start.side = 4
  constants.stock.start.drink = 2
  constants.stock.start.dessert = 3
  constants.stock.start.salad = 1
  constants.stock.serve = {}
  constants.stock.serve.core = 10
  constants.stock.serve.side = 20
  constants.stock.serve.drink = 40
  constants.stock.serve.dessert = 20
  constants.stock.serve.salad = 30

  constants.font = {}
  constants.font.filename = "fonts/Inconsolata-Bold.ttf"
  constants.font.normal = 22
  constants.font.small = 14

  constants.time = {}
  constants.time.stage       =  120 -- 2 hours
  constants.time.start       =  450 --  7:30am
  constants.time.breakfast   =  480 --  8:00am
  constants.time.prep_lunch  =  600 -- 10:00am
  constants.time.lunch       =  660 -- 11:00am
  constants.time.cook        =  840 --  2:00pm
  constants.time.prep_dinner =  960 --  4:00pm
  constants.time.dinner      = 1020 --  5:00pm
  constants.time.cleanup     = 1140 --  7:00pm
  constants.time.done        = 1200 --  8:00pm

  constants.money = {}
  constants.money.initial = 1000
  constants.money.wage = 50

  constants.coords = {}
  constants.coords.start = Coordinate.new(5, 11)
  constants.coords.employee = Coordinate.new(6, 8)
  constants.coords.entrance = Coordinate.new(1, 9)
  constants.coords.exit = Coordinate.new(1, 3)
  constants.coords.exit_off = Coordinate.new(0, 3)
  
  constants.sizes = {}
  constants.sizes.square = 64
  constants.sizes.pawn = 32
  constants.sizes.map = {w=12, h=12}
end
