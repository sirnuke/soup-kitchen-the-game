-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionSlot = {}
MealSelectionSlot.__index = MealSelectionSlot

function MealSelectionSlot.new(requirements)
  local instance = {}
  setmetatable(instance, MealSelectionSlot)
  instance.requirements = requirements
  instance.stock = nil
  instance.label = ''
  for i,req in ipairs(requirements) do
    if i > 1 then instance.label = instance.label .. " OR " end
    instance.label = instance.label .. req
  end
  return instance
end

function MealSelectionSlot:set_selection(stock)
  self.stock = stock
end

function MealSelectionSlot:draw(offset)
end
