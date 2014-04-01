-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Coordinate = {}
Coordinate.__index = Coordinate

Coordinate.__eq = function(a, b) 
  if a.x == b.x and a.y == b.y then
    return true
  else
    return false
  end
end

function Coordinate.new(x, y)
  local instance = { x=x, y=y }
  setmetatable(instance, Coordinate)
  return instance
end

function Coordinate:duplicate()
  return Coordinate.new(self.x, self.y)
end

function Coordinate:screen()
  return Point.new((self.x - 1) * constants.sizes.square, (self.y - 1) * constants.sizes.square)
end

