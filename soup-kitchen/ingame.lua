-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ingame = { }

function ingame.enter()
  ingame.background = love.graphics.newImage("images/ingame/background.png")
end

function ingame.exit()
  ingame.background = nil
end

function ingame.draw()
  love.graphics.draw(ingame.background)
end

function ingame.update(dt)
end

function ingame.keypressed(key)
end

function ingame.keyreleased(key)
end

function ingame.mousepressed(x, y, button)
end

function ingame.mousereleased(x, y, button)
end

