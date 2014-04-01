-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

InteractableClass = {}
InteractableClass.__index = InteractableClass

function InteractableClass.new(point, width, height)
  assert(point and width and height)
  local instance = {}
  setmetatable(InteractableClass, instance)
  instance.point = point:duplicate()
  instance.width = width
  instance.height = height
  instance.pressed = false
  instance.hover = false
  return instance
end

function InteractableClass:update()
  local x, y = love.mouse.getPosition()
  self.hover = self:compare_mouse(x, y)
end

function InteractableClass:compare_mouse(x, y)
  if x >= self.x and x < self.x + self.width and y >= self.y and y < self.y + self.height then
    return true
  else
    return false
  end
end

function InteractableClass:mousepressed()
  self.pressed = self.hover
end

function InteractableClass:trigger()
  if self.pressed and self.hover then
    return true
  else
    return false
  end
end

