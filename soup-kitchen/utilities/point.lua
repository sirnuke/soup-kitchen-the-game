-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Point = {}
Point.__index = Point

function Point.new(x, y)
  local instance = { x=x, y=y }
  setmetatable(instance, Point)
  return instance
end

function Point:duplicate()
  return Point.new(self.x, self.y)
end

function Point:coordinate()
  return Coordinate.new(1 + (self.x - (self.x % C.sizes.square)) / C.sizes.square,
                        1 + (self.y - (self.y % C.sizes.square)) / C.sizes.square)
end

function Point:screen()
  return Point.new(self.x + C.layout.map.x, self.y + C.layout.map.y)
end

function Point.__eq(a, b)
  if a.x == b.x and a.y == b.y then
    return true
  else
    return false
  end
end

function Point.__sub(a, b)
  return Point.new(a.x - b.x, a.y - b.y)
end

function Point.__add(a, b)
  return Point.new(a.x + b.x, a.y + b.y)
end

