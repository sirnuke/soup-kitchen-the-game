-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass

function CustomerClass.new()
  local instance = {}
  setmetatable(instance, CustomerClass)
  return instance
end

