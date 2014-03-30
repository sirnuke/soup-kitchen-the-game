-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

GuiElementClass = {}
GuiElementClass.__index = GuiElementClass

function GuiElementClass:draw()
  assert(false, "Draw isn't overridden!")
end

function GuiElementClass:update(dt)
  assert(false, "Update(dt) isn't overridden!")
end

function GuiElementClass:mousepressed(x, y, button)
  assert(false, "MousePressed(x, y, button) isn't overridden!")
end

