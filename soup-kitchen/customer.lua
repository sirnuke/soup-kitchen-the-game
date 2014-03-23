-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass
CustomerClass.states = { waiting='waiting', inline='inline', gotfood='gotfood', eating='eating' }

function CustomerClass.new()
  local instance = {}
  setmetatable(instance, CustomerClass)
  instance.pawn = nil
  instance.action = nil
  instance.state = nil
  return instance
end

function CustomerClass:spawn()
  self.state = 'waiting'
end

function CustomerClass:update(dt)
  if not self.state then return end

  if self.state == 'waiting' then
    if not map.occupant(core.constants.entry_location.x, core.constants.entry_location.y) then
      self.pawn = PawnClass.new('customer', core.constants.entry_location.x,
        core.constants.entry_location.y)
      self.action = map.actions.drinks
      self.state = 'inline'
    end
  elseif self.state == 'inline' then
    self.pawn:update(dt)
    if self.pawn.coordinate.x ~= self.action.customer.x 
      or self.pawn.coordinate.y ~= self.action.customer.y then
    end
  elseif self.state == 'gotfood' then
    self.pawn:update(dt)
  elseif self.state == 'eating' then
  else
    assert(false, string.format("Unknown customer state of %s", self.state))
  end
end

function CustomerClass:draw()
  if self.pawn then
    self.pawn:draw()
  end
end

