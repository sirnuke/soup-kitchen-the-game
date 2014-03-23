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
  self.action = map.actions.drinks
end

function CustomerClass:spawned()
  if self.pawn then
    return true
  else
    return false
  end
end

function CustomerClass:update(dt)
  if not self.pawn then
    return
  end
  self.pawn:update(dt)
  if not self.action then
    return
  end
  if self.pawn.coordinate.x ~= self.action.customer.x 
    or self.pawn.coordinate.y ~= self.action.customer.y then
    if self.pawn:arrived() then
      if not map.occupant(self.action.customer.x, self.action.customer.y) then
        print("Go to", self.action.customer.x, self.action.customer.y)
        self.pawn:go(self.action.customer.x, self.action.customer.y)
        self.action:reset()
      end
    end
  else
    self.action:update(dt)
    if self.action:finished() then
      self.action = self.action:next(session.stage, self.action)
      if self.action == 'exit' then
        self.pawn:go(core.constants.exit_location.x, core.constants.exit_location.y)
        self.action = nil
      end
    end
  end
end

function CustomerClass:draw()
  if self.pawn then
    self.pawn:draw()
  end
end

