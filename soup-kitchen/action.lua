-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ActionClass = {}
ActionClass.__index = ActionClass
ActionClass.types = {
  drinks='drinks', food1='food1', food2='food2', food3='food3', food4='food4',
  cleaning1='cleaning1', cleaning2='cleaning2', prepare1='prepare1', prepare2='prepare2',
  prepare3='prepare3', prepare4='prepare4', prepare5='prepare5', prepare6='prepare6',
  storage1='storage1', storage2='storage2', storage3='storage3', trash='trash'
}

function ActionClass.new(type, customer, volunteer)
  local instance = {}
  assert(ActionClass.types[type])
  setmetatable(instance, ActionClass)
  instance.type = type
  if customer then
    instance.customer = { x=customer.x,  y=customer.y  }
    assert(not map.blocked(customer.x, customer.y))
    map.data[customer.y][customer.x].action = instance
  end
  assert(not map.blocked(volunteer.x, volunteer.y))
  instance.volunteer = { x=volunteer.x, y=volunteer.y }
  map.data[volunteer.y][volunteer.x].action = instance
  instance.progress = 0
  return instance
end

function ActionClass:next(stage, current)
  if current.type == nil then
    return map.actions.drinks
  elseif current.type == 'drinks' then
    return map.actions.food1
  elseif current.type == 'food1' then
    return map.actions.food2
  elseif current.type == 'food2' then
    if stage == 'breakfast' then
      return nil
    else
      return map.actions.food3
    end
  elseif current.type == 'food3' then
    return map.actions.food4
  elseif current.type == 'food4' then
    return map.actions.cleaning1
  elseif current.type == 'cleaning1' then
    return map.actions.cleaning2
  elseif current.type == 'prepare1' then
    return map.actions.storage1
  elseif current.type == 'prepare2' then
    return map.actions.storage1
  elseif current.type == 'prepare3' then
    return map.actions.storage2
  elseif current.type == 'prepare4' then
    return map.actions.storage2
  elseif current.type == 'prepare5' then
    return map.actions.storage3
  elseif current.type == 'prepare6' then
    return map.actions.storage3
  elseif current.type == 'trash' then
    return nil
  else
    assert(false, string.format("Unhandled type of %s", current.type))
  end
end

function ActionClass:reset()
  self.progress = 0
end

function ActionClass:update(dt)
  local customer, volunteer
  if self.customer then customer = map.occupant(self.customer.x, self.customer.y) end
  if self.volunteer then volunteer = map.occupant(self.volunteer.x, self.volunteer.y) end
  if self.type == 'drinks' then
    if not customer then return end
    if not volunteer then
      table.insert(session.tasks, TaskClass.new('serving', 
        string.format("Missing volunteer at (%i,%i)", self.volunteer.x, self.volunteer.y)))
    elseif volunteer:arrived() then
      self.progress = self.progress + dt * core.constants.execute
      print("Progress is now", self.progress)
    end
    --if self.progress >= core.constants.max_progress then
    --  self.customer
  elseif self.type == 'food1' then
    if not customer then return end
    if not volunteer then
      table.insert(session.tasks, TaskClass.new('serving', 
        string.format("Missing volunteer at (%i,%i)", self.volunteer.x, self.volunteer.y)))
    elseif volunteer:arrived() then
      self.progress = self.progress + dt * core.constants.execute
      print("Progress is now", self.progress)
    end
  elseif self.type == 'food2' then
    if not customer then return end
    if not volunteer then
      table.insert(session.tasks, TaskClass.new('serving', 
        string.format("Missing volunteer at (%i,%i)", self.volunteer.x, self.volunteer.y)))
    elseif volunteer:arrived() then
      self.progress = self.progress + dt * core.constants.execute
      print("Progress is now", self.progress)
    end
  elseif self.type == 'food3' then
  elseif self.type == 'food4' then
  elseif self.type == 'cleaning1' then
  elseif self.type == 'prepare1' then
  elseif self.type == 'prepare2' then
  elseif self.type == 'prepare3' then
  elseif self.type == 'prepare4' then
  elseif self.type == 'prepare5' then
  elseif self.type == 'prepare6' then
  elseif self.type == 'trash' then
  else
    assert(false, string.format("Unhandled action type of %s", self.type))
  end
end

function ActionClass:finished()
  if self.progress >= core.constants.max_progress then
    return true
  else
    return false
  end
end

