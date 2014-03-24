-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(stock)
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.stock = stock
  return instance
end

function MealSelectionOption:draw()
end

