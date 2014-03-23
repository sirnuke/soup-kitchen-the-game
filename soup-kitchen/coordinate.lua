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



