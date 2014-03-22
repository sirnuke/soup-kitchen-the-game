-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

StockClass = {}
StockClass.__index = StockClass

function StockClass.new(type, expiration)
  local instance = {}
  setmetatable(instance, StockClass)
  instance.type = type
  instance.expiration = expiration
  return instance
end

function StockClass:__tostring()
  return string.format("Type:%i Expr:%i", self.type, self.expiration)
end

