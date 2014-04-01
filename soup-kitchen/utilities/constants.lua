-- Soup Kitchen
-- Bryan DeGrendel (c) 2014
C = {}

function C:setup()
  local debug = { fast=3 }

  self.screen = { width=1280, height=720 }

  self.scale = {}
  self.scale.walk = 150
  self.scale.work = 70
  self.scale.clock = 1.25

  if debug then
    self.scale.walk = self.scale.walk * debug.fast
    self.scale.work = self.scale.work * debug.fast
    self.scale.clock = self.scale.clock * debug.fast
  end

  -- Temp self that need a better home
  self.squelch = 0.25
  self.max_progress = 100
  self.breakfast_end = 2

  self.trash = {}
  self.trash.max = 50
  self.trash.food_scale = 0.5

  self.demand = {}
  self.demand.initial = 40
  self.demand.breakfast = .40
  self.demand.lunch = .75
  self.demand.dinner = 1.1

  self.stock = {}
  self.stock.start = {}
  self.stock.start.core = 2
  self.stock.start.side = 4
  self.stock.start.drink = 2
  self.stock.start.dessert = 3
  self.stock.start.salad = 1
  self.stock.serve = {}
  self.stock.serve.core = 10
  self.stock.serve.side = 20
  self.stock.serve.drink = 40
  self.stock.serve.dessert = 20
  self.stock.serve.salad = 30

  self.font = {}
  self.font.filename = "fonts/Inconsolata-Bold.ttf"
  self.font.normal = 22
  self.font.small = 14

  self.time = {}
  self.time.stage       =  120 -- 2 hours
  self.time.start       =  450 --  7:30am
  self.time.breakfast   =  480 --  8:00am
  self.time.prep_lunch  =  600 -- 10:00am
  self.time.lunch       =  660 -- 11:00am
  self.time.cook        =  840 --  2:00pm
  self.time.prep_dinner =  960 --  4:00pm
  self.time.dinner      = 1020 --  5:00pm
  self.time.cleanup     = 1140 --  7:00pm
  self.time.done        = 1200 --  8:00pm

  self.money = {}
  self.money.initial = 1000
  self.money.wage = 50

  self.coords = {}
  self.coords.start = Coordinate.new(5, 11)
  self.coords.employee = Coordinate.new(6, 8)
  self.coords.entrance = Coordinate.new(1, 9)
  self.coords.exit = Coordinate.new(1, 3)
  self.coords.exit_off = Coordinate.new(0, 3)
  
  self.sizes = {}
  self.sizes.square = 64
  self.sizes.pawn = 32
  self.sizes.map = {width=12, height=12}

  self.layout = {}
  self.layout.map = {x=256, y=-24}
  self.layout.ingame = {}

  self.layout.meal_selection = {}
  self.layout.meal_selection.overlay = Point.new(228, 76)
  self.layout.meal_selection.ok     = {offset=Point.new( 20, 528), width=80, height=20}
  self.layout.meal_selection.cancel = {offset=Point.new(120, 528), width=80, height=20}
  self.layout.meal_selection.slots = {}
  self.layout.meal_selection.slots.offset = Point.new(30, 30)
  self.layout.meal_selection.slots.text_buffer = 4
  self.layout.meal_selection.slots.width = 342
  self.layout.meal_selection.slots.height = 20
  self.layout.meal_selection.slots.skip = 30
  self.layout.meal_selection.options = {}
  self.layout.meal_selection.options.offset = Point.new(432, 30)
  self.layout.meal_selection.options.text_buffer = 4
  self.layout.meal_selection.options.width = 342
  self.layout.meal_selection.options.height = 20
  self.layout.meal_selection.options.skip = 30


end

