-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

GetFoodTaskClass = {}
GetFoodTaskClass.__index = GetFoodTaskClass

function GetFoodTaskClass.new(equipment, owner)
  assert(owner)

  local instance = TaskClass.new(equipment, owner)
  setmetatable(instance, GetFoodTaskClass)
  inherits(TaskClass, instance)
  return instance
end

