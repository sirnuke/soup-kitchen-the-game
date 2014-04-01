-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

InteractableClass = {}
InteractableClass.__index = InteractableClass

function InteractableClass.new(point, width, height)
  assert(width and height)
  local instance = {}
  setmetatable(instance, InteractableClass)
  if point then instance.point = point:duplicate() end
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

function InteractableClass:set_point(point)
  if point then
    self.point = point:duplicate()
  else
    self.point = nil
  end
end

function InteractableClass:compare_mouse(x, y)
  if self.point and x >= self.point.x and x < self.point.x + self.width and y >= self.point.y
      and y < self.point.y + self.height then
    return true
  else
    return false
  end
end

function InteractableClass:mousepressed()
  self.pressed = self.hover
end

function InteractableClass:triggered()
  if self.pressed and self.hover then
    return true
  else
    return false
  end
end

