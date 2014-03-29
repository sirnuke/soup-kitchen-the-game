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
  return instance
end

function TaskClass:done()
  return false
end

function TaskClass:description()
  return nil
end

