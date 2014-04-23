-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Help = {}

function Help:enter()
  self.background = love.graphics.newImage("images/help/background.png")
end

function Help:exit()
  self.background = nil
end

function Help:draw()
  Screen:draw(self.background)
end

function Help:update(dt)
end

function Help:keypressed(key)
end

function Help:keyreleased(key)
end

function Help:mousepressed(point, button)
  if button == 'l' then
    Core:switch("InGame")
  end
end

function Help:mousereleased(point, button)
end

