-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass
PawnClass.types = { player='player', employee='employee', volunteer='volunteer',
  customer='customer' }
PawnClass.images = { }

function PawnClass.new(type, x, y)
  assert(not map.blocked(x, y))
  assert(PawnClass.types[type])

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.position = map.position(x, y)
  instance.coordinate = { x=x, y=y }
  instance.destination = nil
  instance.skills = {}

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
end
