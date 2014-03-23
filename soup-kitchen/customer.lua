-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass

function CustomerClass.new()
  local instance = {}
  setmetatable(instance, CustomerClass)
  instance.pawn = nil
  instance.action = nil
  instance.complete = 0
  return instance
end

function CustomerClass:place()
  self.pawn = PawnClass.new('customer', core.constants.entry_location.x,
    core.constants.entry_location.y)
end

function CustomerClass:spawned()
  if self.pawn then
    return true
  else
    return false
  end
end

function CustomerClass:update(dt)
  if self.pawn then
    self.pawn:update(dt)
    if not instance.action then
      self.action = map.actions.drinks
    else
    end
  end
end

function CustomerClass:draw()
  if self.pawn then
    self.pawn:draw()
  end
end

