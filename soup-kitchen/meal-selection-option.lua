-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(stock)
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.stock = stock
  instance.label = tostring(stock)
  return instance
end

function MealSelectionOption:draw(offset)
  love.graphics.print(self.label, 534, 126 + (offset - 1) * 32)
end

