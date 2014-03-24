-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(offset, stock)
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.offset = offset
  instance.stock = stock
  instance.slot = nil
  instance.label = tostring(stock)
  return instance
end

function MealSelectionOption:draw()
  local x, y = self:coord()
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
  love.graphics.draw(image, x, y)
  love.graphics.setColor(0, 0, 0, 224)
  love.graphics.print(self.label, x + 4, y + 4)
end

function MealSelectionOption:coord()
  return 534, 130 + (self.offset - 1) * 30
end

function MealSelectionOption:inbounds(x, y)
end

