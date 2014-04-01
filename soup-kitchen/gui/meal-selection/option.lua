-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(offset, stock, images)
  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.images = images
  instance.location = Point.new(534, 130 + (offset - 1) * 30)
  instance.label_location = Point.new(instance.location.x + 4, instance.location.y + 4)
  instance.gui = InteractableClass.new(instance.location, 342, 20)
  instance.stock = stock
  instance.slot = nil
  instance.label = tostring(stock)
  instance.selected = false
  return instance
end

function MealSelectionOption:update(dt)
  self.gui:update()
end

function MealSelectionOption:mousepressed(point)
  self.gui:mousepressed()
end

function MealSelectionOption:draw()
  local image = nil
  if self.selected then
    image = self.images.selected
  elseif self.slot then
    if self.slot.valid then
      image = self.images.used
    else
      image = self.images.invalid
    end
  else
    image = self.images.normal
  end
  love.graphics.setColor(255, 255, 255, 224)
  Screen:draw(image, self.location)
  love.graphics.setColor(0, 0, 0, 224)
  Screen:print(self.label, self.label_location)
end

function MealSelectionOption:triggered()
  return self.gui:triggered()
end

