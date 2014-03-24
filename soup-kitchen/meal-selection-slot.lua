-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionSlot = {}
MealSelectionSlot.__index = MealSelectionSlot

function MealSelectionSlot.new()
  local instance = {}
  setmetatable(instance, MealSelectionSlot)
  return instance
end
