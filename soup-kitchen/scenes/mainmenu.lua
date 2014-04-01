-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MainMenu = {}

function MainMenu:enter()
  self.background = love.graphics.newImage("images/mainmenu/background.png")
  self.squelch = C.squelch
end

function MainMenu:exit()
  self.background = nil
end

function MainMenu:draw()
  Screen:draw(self.background)
end

function MainMenu:update(dt)
  if self.squelch > 0 then
    self.squelch = self.squelch - dt
  end
end

function MainMenu:keypressed(key)
  if self.squelch <= 0 then
  end
end

function MainMenu:keyreleased(key)
end

function MainMenu:mousepressed(point, button)
  if self.squelch <= 0 and button == 'l' then
    Core:switch("Help")
  end
end

function MainMenu:mousereleased(point, button)
end

