-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass
TaskClass.types = { serving='serving' }

function TaskClass.new(type)
  assert(TaskClass.types[type])

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.type = type
  return instance
end

