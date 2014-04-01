-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Point = {}
Point.__index = Point

Point.__eq = function(a, b)
  if a.x == b.x and a.y == b.y then
    return true
  else
    return false
  end
end

function Point.new(x, y)
  local instance = { x=x, y=y }
  setmetatable(instance, Point)
  return instance
end

function Point:duplicate()
  return Point.new(self.x, self.y)
end

