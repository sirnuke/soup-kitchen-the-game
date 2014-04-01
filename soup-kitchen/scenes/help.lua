-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Help = {}

function Help:enter()
  self.background = love.graphics.newImage("images/help/background.png")
  self.squelch = C.squelch
end

function Help:exit()
  self.background = nil
end

function Help:draw()
  Screen:draw(self.background)
end

function Help:update(dt)
  if self.squelch > 0 then
    self.squelch = self.squelch - dt
  end
end

function Help:keypressed(key)
  if self.squelch <= 0 then
  end
end

function Help:keyreleased(key)
end

function Help:mousepressed(point, button)
  if self.squelch <= 0 and button == 'l' then
    Core:switch("InGame")
  end
end

function Help:mousereleased(point, button)
end

