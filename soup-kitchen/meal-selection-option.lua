-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new()
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  return instance
end

