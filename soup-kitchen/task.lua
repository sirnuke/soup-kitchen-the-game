-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving', stock='stocking' }

function TaskClass.new(type, locations, owner)
  assert(TaskClass.types[type])
  assert(locations)

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  instance.locations = locations
  instance.progress = 0
  instance.owner = owner
  print("Creating task", type, owner)
  if type == 'serving' then
    assert(#locations == 2)
    assert(owner)
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
  if self.type == 'serving' then
    local customer, volunteer = map.occupant(self.locations[1]), map.occupant(self.locations[2])
    if customer == self.owner and volunteer and customer:arrived() and volunteer:arrived() then
      self.progress = self.progress + dt * constants.scale.work
    end
  elseif self.type == 'stocking' then
  else
    assert(false, string.format("Unhandled task type of %s", self.type))
  end
end

