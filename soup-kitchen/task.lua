-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving', stock='stocking' }

function TaskClass.new(type, locations)
  assert(TaskClass.types[type])
  assert(locations)

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  instance.locations = locations
  instance.progress = 0
  if type == 'serving' then
    assert(#locations == 2)
  elseif type == 'stocking' then
  else
    assert(false, string.format("Unhandled task type of %s", type))
  end
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
  print("Updating task", dt)
  if self.type == 'serving' then
    local customer, volunteer = map.occupant(self.locations[1]), map.occupant(self.locations[2])
    if customer and volunteer and customer.type == 'customer' and customer:arrived() 
      and volunteer:arrived() then
      self.progress = self.progress + dt * constants.scale.work
    end
  elseif self.type == 'stocking' then
  else
    assert(false, string.format("Unhandled task type of %s", self.type))
  end
end

