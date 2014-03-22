-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

StockClass = {}
StockClass.__index = StockClass
StockClass.types = { 'core', 'side', 'drink', 'desert' }

function StockClass.new(type, expiration)
  local instance = {}
  setmetatable(instance, StockClass)
  instance.type = type
  instance.expiration = expiration
  instance.prepared = false
  return instance
end

function StockClass:__tostring()
  return string.format("Type:%i Expr:%i Prep:%s", self.type, self.expiration,
    tostring(self.prepared))
end

