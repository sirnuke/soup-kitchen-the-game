-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ObjectClass = {}
ObjectClass.__index = ObjectClass

function ObjectClass.new()
  local instance = {}
  instance.holder = nil
  instance.location = nil
  return instance
end

function ObjectClass:grabbed(holder)
  assert(not self.location or not self.holder and holder)
  self.location = nil
  self.holder = holder
end

function ObjectClass:dropped(location)
  assert(not self.location or not self.holder and location)
  self.location = location
  self.holder = nil
end

