-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving' }

function TaskClass.new(type, description)
  assert(TaskClass.types[type])

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  instance.description = description
  return instance
end

