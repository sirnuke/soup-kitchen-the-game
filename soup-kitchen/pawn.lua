-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass
PawnClass.types = { player='player', employee='employee', volunteer='volunteer',
  customer='customer' }
PawnClass.images = { }

function PawnClass.new(type, x, y)
  assert(not map.blocked(x, y))
  assert(not map.occupant(x, y))
  assert(PawnClass.types[type])

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.position = map.position(x, y)
  instance.coordinate = { x=x, y=y }
  instance.destination = nil
  instance.skills = {}

  map.setoccupant(x, y, instance)

  if type == 'player' then
    if not PawnClass.images.player then
      PawnClass.images.player = love.graphics.newImage("images/pawns/player.png")
    end
  elseif type == 'employee' then
  elseif type == 'volunteer' then
  elseif type == 'customer' then
  else
    assert(false, string.format("Unhandled pawn type %s", type))
  end

  return instance
end

function PawnClass:draw()
  love.graphics.draw(PawnClass.images[self.type], self.position.x, self.position.y)
end

function PawnClass:go(x, y)
  assert(not map.blocked(x, y))
  assert(not map.occupant(x, y))

  map.setoccupant(self.coordinate.x, self.coordinate.y, nil)
  map.setoccupant(x, y, self)
  self.coordinate.x = x
  self.coordinate.y = y
  --
  data = { }
  --self.destination
end

function PawnClass:update(dt)
  if self.destination then
    self.position = self.destination
    self.destination = nil
  end
end

function PawnClass:clicked(x, y)
  if x >= self.position.x and x < self.position.x + core.sizes.pawn.width and
     y >= self.position.y and y < self.position.y + core.sizes.pawn.height then
     return true
   else
     return false
   end
end

