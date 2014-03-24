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
  instance.valid = false
  for i,req in ipairs(requirements) do
    if i > 1 then instance.label = instance.label .. " OR " end
    instance.label = instance.label .. req
  end
  return instance
end

function MealSelectionSlot:set_selection(stock)
  self.selection = stock
  self.valid = false
  self.selection_label = nil
  if self.selection then
    for id,req in ipairs(self.requirements) do
      if req == self.selection.type then self.valid = true end
    end
    self.selection_label = " - " .. tostring(self.selection)
  end
end

function MealSelectionSlot:draw(offset)
  -- bleh
  local x, y = self:coord(offset)
  local image = nil
  if meal_selection.selected then
    image = meal_selection.elements.normal
    for i,req in ipairse(self.requirements) do
      if req == meal_selection.selected.stock.type then
        image = meal_selection.elements.selected
      end
    end
  else
    if self.valid then
      image = meal_selection.elements.used
    elseif not self.selection then
      image = meal_selection.elements.normal
    else
      image = meal_selection.elements.invalid
    end
  end
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(image, x, y)
  love.graphics.setColor(0, 0, 0, 224)
  love.graphics.print(self.label, x + 4, y + 4)
  if self.selection_label then
    love.graphics.print(self.selection_label, x + 4 + 171, y + 4)
  end
end

function MealSelectionSlot:coord(offset)
  return 130, 130 + (offset - 1) * 30
end

function MealSelectionSlot:inbounds(offset, x, y)
end
