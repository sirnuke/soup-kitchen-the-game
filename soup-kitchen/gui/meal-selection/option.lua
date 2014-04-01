-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionOption = {}
MealSelectionOption.__index = MealSelectionOption

function MealSelectionOption.new(offset, stock, images)
  local text_buffer = C.layout.meal_selection.options.text_buffer

  local instance = {}
  setmetatable(instance, MealSelectionOption)
  instance.images = images
  instance.location = C.layout.meal_selection.overlay + C.layout.meal_selection.options.offset
  instance.location.y = instance.location.y + (offset - 1) * C.layout.meal_selection.options.skip
  instance.label_location = Point.new(instance.location.x + text_buffer,
    instance.location.y + text_buffer)
  instance.gui = InteractableClass.new(instance.location, C.layout.meal_selection.options.width,
    C.layout.meal_selection.options.height)
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

