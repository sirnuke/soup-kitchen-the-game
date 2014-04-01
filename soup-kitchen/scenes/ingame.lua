-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

InGame = {}

function InGame:enter()
  self.background = love.graphics.newImage("images/ingame/background.png")
  self.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  self.selected_overlay = love.graphics.newImage("images/ingame/selected-overlay.png")
  self.paused = false
  self.selected = nil
  self.font_normal = love.graphics.setNewFont(constants.font.filename, constants.font.normal)
  self.font_small = love.graphics.setNewFont(constants.font.filename, constants.font.small)
  self.meal_selection = MealSelection
  self.meal_selection:setup()
  session.start()
end

function InGame:exit()
  self.meal_selection:destroy()
  self.background = nil
  self.warning_icon = nil
  self.selected_overlay = nil
  self.font_normal = nil
  self.font_small = nil
end

function InGame:draw()
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
  local count, description = 0, nil
  for k,v in ipairs(session.tasks) do
    if count < 6 then
      description = v:description()
      if description then
        love.graphics.print(description, 778, 138 + ((count - 1) * 32))
        count = count + 1
      end
    elseif count == 6 then
      love.graphics.print("...", 778, 138 + ((count - 1) * 32))
      count = count + 1
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

function InGame:update(dt)
  if meal_selection.active then
    meal_selection:update(dt)
  elseif not ingame.paused then
    session.update(dt)
  end
end

function InGame:keypressed(key)
  if meal_selection.active then
    meal_selection:keypressed(key)
  elseif key == 'escape' or key == 'space' then
    ingame.paused = not ingame.paused
  end
end

function InGame:keyreleased(key)
end

function InGame:mousepressed(point, button)
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

function InGame.mousereleased(point, button)
  if meal_selection.active then
    meal_selection:mousereleased(x, y, button)
  end
end

