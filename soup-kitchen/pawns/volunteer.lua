-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

VolunteerClass = {}
VolunteerClass.__index = VolunteerClass

function VolunteerClass.new(map)
  if not PlayerClass.image then
    VolunteerClass.image = love.graphics.newImage("images/pawns/volunteer.png")
  end

  local instance = PawnClass.new(map, nil)
  setmetatable(instance, VolunteerClass)
  inherits(PawnClass, instance)
  return instance
end

