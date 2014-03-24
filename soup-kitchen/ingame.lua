-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ingame = { }

function ingame.enter()
  ingame.background = love.graphics.newImage("images/ingame/background.png")
  ingame.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  ingame.selected_overlay = love.graphics.newImage("images/ingame/selected-overlay.png")
  ingame.paused = false
  ingame.selected = nil
  ingame.font_normal = love.graphics.setNewFont(constants.font.filename, constants.font.normal)
  ingame.font_small = love.graphics.setNewFont(constants.font.filename, constants.font.small)
  meal_selection:setup()
  ActionClass.setup()
  map.create()
  session.start()
end

function ingame.exit()
  meal_selection:destroy()
  ingame.background = nil
  ingame.warning_icon = nil
  ingame.selected_overlay = nil
  ingame.font_normal = nil
  ingame.font_small = nil
end

function ingame.draw()
  love.graphics.draw(ingame.background)
  -- Draw pawns
  session.draw()

  -- Draw GUI elements
  love.graphics.setColor(255, 255, 255, 255)
  if ingame.selected then
    love.graphics.draw(ingame.selected_overlay, ingame.selected.screen.x,
      ingame.selected.screen.y)
  end
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(ingame.font_normal)
  love.graphics.print(string.format("Day %i %s $%i", session.day, session.format_time(), session.cash), 778, 10)
  love.graphics.print(session.name_stage(), 778, 74)
  love.graphics.print(string.format("#%i Eating", session.eating_count()), 8, 334)
  love.graphics.print(string.format("#%i Queued", session.line_count()), 8, 398)
  love.graphics.setFont(ingame.font_small)
  for k,v in ipairs(session.stock) do
    if k < 14 then
      love.graphics.print(tostring(v), 778, 330 + ((k - 1) * 32))
    elseif k == 14 then
      love.graphics.print("...", 778, 330 + ((k - 1) * 32))
    else
    end
  end
  for k,v in ipairs(session.tasks) do
    if k < 6 then
      love.graphics.print(v.description, 778, 138 + ((k - 1) * 32))
    elseif k == 6 then
      love.graphics.print("...", 778, 138 + ((k - 1) * 32))
    end
  end
  love.graphics.setColor(255, 255, 255, 255)
  if meal_selection.active then
    meal_selection:draw()
  elseif ingame.paused then
    love.graphics.setColor(128, 128, 128, 192)
    love.graphics.rectangle("fill", 228, 100, 568, 568)
  end
end

function ingame.update(dt)
  if meal_selection.active then
    meal_selection:update(dt)
  elseif not ingame.paused then
    session.update(dt)
  end
end

function ingame.keypressed(key)
  if meal_selection.active then
    meal_selection:keypressed(key)
  elseif key == 'escape' or key == 'space' then
    ingame.paused = not ingame.paused
  end
end

function ingame.keyreleased(key)
end

function ingame.mousepressed(x, y, button)
  if meal_selection.active then
    meal_selection:mousepressed(x, y, button)
  elseif not ingame.paused then
    if button == 'l' then
      if session.player:clicked(x, y) then
        ingame.selected = session.player
      else
        ingame.selected = nil
      end
    elseif button == 'r' then
      local coord = map.coordinate(x, y)
      if ingame.selected and not map.blocked(coord) and not map.occupant(coord) then
        ingame.selected:go(coord)
      end
    end
  end
end

function ingame.mousereleased(x, y, button)
  if meal_selection.active then
    meal_selection:mousereleased(x, y, button)
  end
end

