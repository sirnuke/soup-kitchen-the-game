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
  instance.selection_label = nil
  for i,req in ipairs(requirements) do
    if i > 1 then instance.label = instance.label .. " OR " end
    instance.label = instance.label .. req
  end
  return instance
end

function MealSelectionSlot:set_selection(stock)
  self.stock = stock
  if self.stock then
    self.selection_label = " - " .. tostring(self.stock)
  else
    self.selection_label = nil
  end
end

function MealSelectionSlot:draw(offset)
  -- bleh
  local imgoffset, txtoffset, height = 130, 134, 30
  local txt2offset = txtoffset + 171
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(meal_selection.elements.normal, imgoffset, imgoffset + (offset - 1) * height)
  love.graphics.setColor(0, 0, 0, 224)
  love.graphics.print(self.label, txtoffset, txtoffset + (offset - 1) * height)
  if self.selection_label then
    love.graphics.print(self.selection_label, txt2offset, txtoffset + (offset - 1) * height)
  end
end
