-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

GetFoodTaskClass = {}
GetFoodTaskClass.__index = GetFoodTaskClass

function GetFoodTaskClass.new(equipment, owner)
  assert(owner)

  local instance = {}
  setmetatable(instance, GetFoodTaskClass)
  inherits(TaskClass.new(equipment, owner), instance)
  return instance
end

