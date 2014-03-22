-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ingame = { }

function ingame.enter()
  ingame.background = love.graphics.newImage("images/ingame/background.png")
  ingame.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  ingame.selected_overlay = love.graphics.newImage("images/ingame/selected-overlay.png")
  ingame.paused = false
  ingame.selected = nil
  map.create()
  session.start()
end

function ingame.exit()
  ingame.background = nil
  ingame.warning_icon = nil
  ingame.selected_overlay = nil
end

function ingame.draw()
  love.graphics.draw(ingame.background)
  -- Draw pawns
  session.player:draw()

  -- Draw GUI elements
  if ingame.selected then
    love.graphics.draw(ingame.selected_overlay, ingame.selected.position.x,
      ingame.selected.position.y)
  end
  if ingame.paused then
    love.graphics.setColor(128, 128, 128, 192)
    love.graphics.rectangle("fill", 228, 100, 568, 568)
  end
end

function ingame.update(dt)
  if not ingame.paused then
    session.player:update(dt)
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
  if not ingame.paused then
    if button == 'l' then
      if session.player:clicked(x, y) then
        ingame.selected = session.player
      else
        ingame.selected = nil
      end
    elseif button == 'r' then
      local coord = map.coordinate(x, y)
      if ingame.selected and not map.blocked(coord.x, coord.y) 
        and not map.occupant(coord.x, coord.y) then
        ingame.selected:go(coord.x, coord.y)
      end
    end
  end
end

function ingame.mousereleased(x, y, button)
end

