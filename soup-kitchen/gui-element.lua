-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

GuiElementClass = {}
GuiElementClass.__index = GuiElementClass

function GuiElementClass.new(coord, width, height, images)
  assert(coord and width and height and images)
  assert(type(images) == 'table' and images.normal and images.pressed and images.hover)
  local instance = {}
  setmetatable(GuiElementClass, instance)
  instance.coord = coord
  instance.width = width
  instance.height = height
  instance.images = images
  instance.screen = instance:screen_coord(instance.coord)
  instance.pressed = false
  instance.hover = false
  return instance
end

function GuiElementClass:screen_coord(coord)
  return { x= (coord.x - 1) * constants.sizes.square, y= (coord.y - 1) * constants.sizes.square }
end

function GuiElementClass:draw()
  local image = nil
  if self.hover then
    if self.pressed then
      image = self.images.pressed
    else
      image = self.images.hover
    end
  else
    image = self.images.normal
  end
  love.graphics.draw(image, self.screen.x, self.screen.y)
end

function GuiElementClass:trigger()
  assert(false, "Trigger() isn't overridden!")
end

function GuiElementClass:update(dt)
  local x, y = love.mouse.getPosition()
  if self:compare_mouse(x, y) then
    self.hover = true
  else
    self.hover = false
  end
end

function GuiElementClass:compare_mouse(x, y)
  if x >= self.screen.x and x < self.screen.x + self.width and y >= self.screen.y 
      and y < self.screen.y + self.height then
    return true
  else
    return false
  end
end

function GuiElementClass:mousepressed(x, y, button)
  if self:compare_mouse(x, y) then
    self.pressed = true
  else
    self.pressed = false
  end
end

function GuiElementClass:mousereleased(x, y, button)
  if self.pressed and self.hover then
    self:trigger()
  end
end

