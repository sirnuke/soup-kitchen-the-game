-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass
CustomerClass.states = { waiting='waiting', inline='inline', gotfood='gotfood', eating='eating' }
CustomerClass.image = nil

function CustomerClass.new(map, stage)
  if not CustomerClass.image then
    CustomerClass.image = love.graphics.newImage("images/pawns/customer.png")
  end

  local instance = {}
  setmetatable(instance, CustomerClass)
  inherits(PawnClass.new(map, nil), instance)
  instance.equipment = nil
  instance.state = 'waiting'
  instance.stage = stage
  instance.task = nil
  return instance
end

function CustomerClass:update(dt)
  if self.state == 'waiting' then
    if not map.occupant(constants.coords.entrance) then
      self.equipment = map.equipment.dispensing.trays
      self.task = GetFoodTaskClass.new(self.equipment, self)
      table.insert(session.tasks, self.task)
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
      else
        self.task = TaskClass.new('serving', self.action, self.pawn)
        table.insert(session.tasks, self.task)
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

