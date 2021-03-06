-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Coordinate = {}
Coordinate.__index = Coordinate

function Coordinate.new(x, y)
  local instance = { x=x, y=y }
  setmetatable(instance, Coordinate)
  return instance
end

function Coordinate:duplicate()
  return Coordinate.new(self.x, self.y)
end

function Coordinate:point()
  return Point.new((self.x - 1) * C.sizes.square, (self.y - 1) * C.sizes.square)
end

function Coordinate:screen()
  local point = self:point()
  return point:screen()
end

function Coordinate:valid()
  if self.x >= 1 and self.x <= C.sizes.map.width and self.y >= 1
    and self.y <= C.sizes.map.height then
    return true
  else
    return false
  end
end

function Coordinate.__eq(a, b) 
  if a.x == b.x and a.y == b.y then
    return true
  else
    return false
  end
end

