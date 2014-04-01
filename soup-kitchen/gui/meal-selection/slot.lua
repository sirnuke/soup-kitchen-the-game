-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelectionSlot = {}
MealSelectionSlot.__index = MealSelectionSlot

function MealSelectionSlot.new(offset, requirements, images)
  local width = C.layout.meal_selection.slots.width
  local text_buffer = C.layout.meal_selection.slots.text_buffer

  local instance = {}
  setmetatable(instance, MealSelectionSlot)
  instance.requirements = requirements
  instance.images = images

  instance.location = C.layout.meal_selection.overlay + C.layout.meal_selection.slots.offset
  instance.location.y = instance.location.y + (offset - 1) * C.layout.meal_selection.slots.skip

  print("x,y", instance.location.x, instance.location.y)


  instance.label_location = Point.new(instance.location.x + text_buffer,
    instance.location.y + text_buffer)

  instance.stock_label_location = Point.new(instance.location.x + text_buffer + width / 2,
    instance.location.y + text_buffer)

  instance.gui = InteractableClass.new(instance.location, width,
    C.layout.meal_selection.slots.height)
  instance.stock = nil
  instance.label = ''
  instance.stock_label = nil
  instance.valid = false
  for i,req in ipairs(requirements) do
    if i > 1 then instance.label = instance.label .. " OR " end
    instance.label = instance.label .. req
  end
  return instance
end

function MealSelectionSlot:set_stock(stock)
  self.stock = stock
  self.valid = false
  if self.stock then
    for id,req in ipairs(self.requirements) do
      if req == stock.type then self.valid = true end
    end
    self.stock_label = " - " .. tostring(stock)
  else
    self.stock_label = nil
  end
end

function MealSelectionSlot:update(dt)
  self.gui:update()
end

function MealSelectionSlot:mousepressed(point)
  self.gui:mousepressed()
end

function MealSelectionSlot:draw(selected_option)
  local image = nil
  if selected_option then
    image = self.images.normal
    for i,req in ipairs(self.requirements) do
      if req == selected_option.stock.type then
        image = self.images.selected
      end
    end
  else
    if self.valid then
      image = self.images.used
    elseif not self.stock then
      image = self.images.normal
    else
      image = self.images.invalid
    end
  end
  love.graphics.setColor(255, 255, 255, 224)
  Screen:draw(image, self.location)
  love.graphics.setColor(0, 0, 0, 224)
  Screen:print(self.label, self.label_location)
  if self.stock_label then
    Screen:print(self.stock_label, self.stock_label_location)
  end
end

function MealSelectionSlot:triggered()
  return self.gui:triggered()
end

