-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ingame = { }

function ingame.enter()
  ingame.background = love.graphics.newImage("images/ingame/background.png")
  ingame.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  ingame.paused = false
  map.create()
  session.start()
end

function ingame.exit()
  ingame.background = nil
  ingame.warning_icon = nil
end

function ingame.draw()
  love.graphics.draw(ingame.background)
  -- Draw GUI elements
  -- Draw sprites here
  session.player:draw()
  if ingame.paused then
    love.graphics.setColor(128, 128, 128, 192)
    love.graphics.rectangle("fill", 228, 100, 568, 568)
  end
end

function ingame.update(dt)
  if not ingame.paused then
    -- update pawns
    -- update session
  end
end

function ingame.keypressed(key)
  if key == 'escape' then
    ingame.paused = not ingame.paused
  end
end

function ingame.keyreleased(key)
end

function ingame.mousepressed(x, y, button)
end

function ingame.mousereleased(x, y, button)
end

