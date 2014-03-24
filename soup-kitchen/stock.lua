-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

StockClass = {}
StockClass.__index = StockClass
StockClass.types = { core='core', side='side', drink='drink', dessert='dessert', salad='salad' }

function StockClass.new(type, quantity, expiration)
  assert(StockClass.types[type])
  assert(expiration > 0)
  assert(quantity > 0)

  local instance = {}
  setmetatable(instance, StockClass)
  instance.type = type
  instance.expiration = expiration
  instance.quantity = quantity
  instance.prepared = false
  return instance
end

function StockClass:__tostring()
  return string.format("%i of %s (prep:%s) expires in %i", self.quantity,
    StockClass.types[self.type], tostring(self.prepared), self.expiration)
end

function StockClass:expire()
  self.expired = self.expired - 1
  if self.expired <= 0 then
    return true
  else
    return false
  end
end

function StockClass:use(amount)
  self.quantity = self.quantity - amount
  if self.quantity <= 0 then
    return true
  else
    return false
  end
end

function StockClass:prepare()
  assert(self.type == 'core' or self.type == 'side')
  self.prepared = true
  self.expiration = 3
end

function StockClass:ready()
  if self.type == 'core' or self.type == 'side' then
    return self.prepared
  else
    return true
  end
end

function StockClass.random(type, prepared)
  assert(StockClass.types[type])

  local quantity, expiration = 0, 0

  if type == 'core' then
    quantity = love.math.randomNormal(5, 20)
    expiration = love.math.randomNormal(2, 7)
  elseif type == 'side' then
    quantity = love.math.randomNormal(5, 20)
    expiration = love.math.randomNormal(3, 10)
  elseif type == 'drink' then
    quantity = love.math.randomNormal(10, 30)
    expiration = love.math.randomNormal(2, 7)
  elseif type == 'dessert' then
    quantity = love.math.randomNormal(3, 15)
    expiration = love.math.randomNormal(1, 3)
  elseif type == 'salad' then
    quantity = love.math.randomNormal(10, 30)
    expiration = love.math.randomNormal(2, 6)
  else
    assert(false, string.format("Unhandled type %s", type))
  end

  if quantity <= 0 then
    print(string.format("Generated bad quantity of %i", quantity))
    quantity = 1
  end
  if expiration <= 0 then
    print(string.format("Generated bad expiration of %i", expiration))
    expiration = 1
  end
  local stock = StockClass.new(type, quantity, expiration)
  if prepared and (type == 'core' or type == 'side') then
    stock:prepare()
  end
  return stock
end

