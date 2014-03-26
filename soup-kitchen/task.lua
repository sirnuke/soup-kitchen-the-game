-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving', stock='stocking' }

function TaskClass.new(type, description, locations)
  assert(TaskClass.types[type])
  assert(description)
  assert(locations)

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  instance.description = description
  instance.locations = locations
  return instance
end

