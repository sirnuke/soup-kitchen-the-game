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
  instance.state = 'waiting'
  return instance
end

function CustomerClass:update(dt)
  if self.state == 'waiting' then
    if not map.occupant(constants.coords.entrance) then
      self.pawn = PawnClass.new('customer', 'enter')
      self.action = map.actions.drinks
      self.state = 'inline'
    end
  elseif self.state == 'inline' then
    self.pawn:update(dt)
    if self.pawn.coordinate ~= self.action.customer then
      if not map.occupant(self.action.customer) and self.pawn:arrived() then
        self.pawn:go(self.action.customer)
      end
    elseif self.action:finished() then
      self.action:reset()
      self.action = self.action:next(session.stage)
      if self.action == 'done' then
        -- self.pawn:leave()
        self.state = 'gotfood'
      end
    end
  elseif self.state == 'gotfood' then
    self.pawn:update(dt)
    -- if self.pawn:left() then
    -- despawn
    -- end
  elseif self.state == 'eating' then
    -- update eating counter
  else
    assert(false, string.format("Unknown customer state of %s", self.state))
  end
end

function CustomerClass:draw()
  if self.pawn then
    self.pawn:draw()
  end
end

