-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass
PawnClass.types = { player='player', employee='employee', volunteer='volunteer',
  customer='customer' }

function PawnClass.new(type, x, y)
  assert(not map.blocked(x, y))
  assert(PawnClass.types[type])

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.x, instance.y = map.coordinate(x, y)
  instance.destination = nil
  instance.skills = {}
end
