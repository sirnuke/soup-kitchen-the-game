-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass
CustomerClass.states = { waiting='waiting', inline='inline', gotfood='gotfood', eating='eating' }

function CustomerClass.new(stage)
  local instance = {}
  setmetatable(instance, CustomerClass)
  instance.pawn = nil
  instance.action = nil
  instance.state = 'waiting'
  instance.stage = stage
  instance.task = nil
  return instance
end

function CustomerClass:update(dt)
  if self.state == 'waiting' then
    if not map.occupant(constants.coords.entrance) then
      self.task = TaskClass.new('serving', { map.actions.serving[1].customer, 
        map.actions.serving[1].volunteer })
      table.insert(session.tasks, self.task)
      self.pawn = PawnClass.new('customer', 'enter')
      self.action = map.actions.serving[1]
      self.pawn.action = self.action
      self.state = 'inline'
    end
  elseif self.state == 'inline' then
    self.pawn:update(dt)
    if self.pawn.coordinate ~= self.action.customer then
      if not map.occupant(self.action.customer) and self.pawn:arrived() then
        self.pawn:go(self.action.customer)
      end
    elseif self.task:done() then
      self.action = self.action:next(self.stage)
      self.pawn.action = self.action
      if self.action == 'done' then
        self.pawn:leave()
        self.state = 'gotfood'
      end
    end
  elseif self.state == 'gotfood' then
    self.pawn:update(dt)
    if self.pawn.exited then
      self.pawn = nil
      self.state = 'eating'
    end
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

