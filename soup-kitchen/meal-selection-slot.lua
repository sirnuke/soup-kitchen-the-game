-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionSlot = {}
MealSelectionSlot.__index = MealSelectionSlot

function MealSelectionSlot.new(requirements)
  local instance = {}
  setmetatable(instance, MealSelectionSlot)
  instance.requirements = requirements
  instance.stock = nil
  return instance
end

function MealSelectionSlot:set_selection(stock)
  self.stock = stock
end

function MealSelectionSlot:draw()
end
