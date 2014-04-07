-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ObjectClass = {}
ObjectClass.__index = ObjectClass

function ObjectClass.new(parent)
  local instance = {}
  instance.parent = parent
  return instance
end

