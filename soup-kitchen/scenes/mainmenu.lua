-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MainMenu = {}

function MainMenu:enter()
  self.background = love.graphics.newImage("images/mainmenu/background.png")
end

function MainMenu:exit()
  self.background = nil
end

function MainMenu:draw()
  Screen:draw(self.background)
end

function MainMenu:update(dt)
end

function MainMenu:keypressed(key)
end

function MainMenu:keyreleased(key)
end

function MainMenu:mousepressed(point, button)
  if button == 'l' then
    Core:switch("Help")
  end
end

function MainMenu:mousereleased(point, button)
end

