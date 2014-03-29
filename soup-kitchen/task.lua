-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving', stock='stocking' }

function TaskClass.new(type, action, owner)
  assert(TaskClass.types[type])
  assert(action)

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  instance.action = action
  instance.progress = 0
  instance.owner = owner
  print("Creating task", type, owner)
  return instance
end

function TaskClass:done()
  if self.progress >= constants.max_progress then
    return true
  else
    return false
  end
end

function TaskClass:description()
  return nil
end

function TaskClass:update(dt)
  if self.type == 'serving' then
    local customer, volunteer = map.occupant(self.action.customer),
      map.occupant(self.action.volunteer)
    if customer == self.owner and volunteer and customer:arrived() and volunteer:arrived() then
      self.progress = self.progress + dt * constants.scale.work
    end
  elseif self.type == 'stocking' then
  else
    assert(false, string.format("Unhandled task type of %s", self.type))
  end
end

function TaskClass:draw()
  if self.type == 'serving' then
    local customer, volunteer = map.occupant(self.action.customer),
      map.occupant(self.action.volunteer)
    if not customer == self.owner then
      love.graphics.draw(ActionClass.images.potential, self.action.screen.customer.x,
        self.action.screen.customer.y)
      love.graphics.draw(ActionClass.images.potential, self.action.screen.volunteer.x,
        self.action.screen.volunteer.y)
    elseif not volunteer or volunteer:arrived() then
    else
    end
  elseif selt.type == 'stocking' then
  else
    assert(false, string.format("Unhandled task type of %s", self.type))
  end
end

