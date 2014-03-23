-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ingame = { }

function ingame.enter()
  ingame.background = love.graphics.newImage("images/ingame/background.png")
  ingame.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  ingame.selected_overlay = love.graphics.newImage("images/ingame/selected-overlay.png")
  ingame.paused = false
  ingame.selected = nil
  ingame.gui_font = love.graphics.setNewFont("fonts/Inconsolata-Bold.ttf", core.constants.font_size)
  ingame.gui_font_small = love.graphics.setNewFont("fonts/Inconsolata-Bold.ttf", core.constants.small_font_size)
  map.create()
  session.start()
end

function ingame.exit()
  ingame.background = nil
  ingame.warning_icon = nil
  ingame.selected_overlay = nil
  ingame.gui_font = nil
  ingame.gui_font_small = nil
end

function ingame.draw()
  love.graphics.draw(ingame.background)
  -- Draw pawns
  session.player:draw()

  -- Draw GUI elements
  love.graphics.setColor(0, 0, 0, 255)
  if ingame.selected then
    love.graphics.draw(ingame.selected_overlay, ingame.selected.screen.x,
      ingame.selected.screen.y)
  end
  love.graphics.setFont(ingame.gui_font)
  love.graphics.print(string.format("Day %i %s $%i", session.day, session.format_time(), session.cash), 778, 10)
  love.graphics.print(session.stage, 778, 74)
  love.graphics.print(string.format("#%i Eating", session.eating_count()), 8, 334)
  love.graphics.print(string.format("#%i Queued", session.line_count()), 8, 398)
  love.graphics.setFont(ingame.gui_font_small)
  for k,v in ipairs(session.stock) do
    if k < 14 then
      love.graphics.print(tostring(v), 778, 330 + ((k - 1) * 32))
    elseif k == 14 then
      love.graphics.print("...", 778, 330 + ((k - 1) * 32))
    else
    end
  end
  -- for kv in ipairs(session.tasks) do
  -- end
  love.graphics.print("Tasks!", 778, 134)
  if ingame.paused then
    love.graphics.setColor(128, 128, 128, 192)
    love.graphics.rectangle("fill", 228, 100, 568, 568)
  end
end

function ingame.update(dt)
  if not ingame.paused then
    session.update(dt)
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

