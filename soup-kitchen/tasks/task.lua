-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

TaskClass = {}
TaskClass.__index = TaskClass

function TaskClass.new(equipment, owner)
  assert(action)

  local instance = {}
  setmetatable(instance, TaskClass)
  instance.equipment = equipment
  instance.owner = owner
  return instance
end

function TaskClass:done()
  assert(false, "Task doesn't implement done()")
end

-- Defaults to 'nil' (no task list description)
function TaskClass:description()
  return nil
end

function TaskClass:update(dt)
  assert(false, "Task doesn't implement update(dt)")
end

function TaskClass:draw()
  assert(false, "Task doesn't implement draw()")
end

