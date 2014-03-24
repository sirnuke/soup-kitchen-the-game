-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(stock)
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.stock = stock
  instance.slot = nil
  instance.label = tostring(stock)
  return instance
end

function MealSelectionOption:draw(offset)
  local image = nil
  if meal_selection.selected == self then
    image = meal_selection.elements.selected
  elseif self.slot then
    if self.slot.valid then
      image = meal_selection.elements.used
    else
      image = meal_selection.elements.invalid
    end
  else
    image = meal_selection.elements.normal
  end
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(image, 534, 130 + (offset - 1) * 30)
  love.graphics.setColor(0, 0, 0, 224)
  love.graphics.print(self.label, 538, 134 + (offset - 1) * 30)
end

