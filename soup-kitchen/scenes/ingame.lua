-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

InGame = {}

function InGame:enter()
  self.background = love.graphics.newImage("images/ingame/background.png")
  self.warning_icon = love.graphics.newImage("images/ingame/warning-icon.png")
  self.selected_overlay = love.graphics.newImage("images/ingame/selected-overlay.png")
  self.paused = false
  self.selected = nil
  self.font_normal = love.graphics.setNewFont(C.font.filename, C.font.normal)
  self.font_small = love.graphics.setNewFont(C.font.filename, C.font.small)
  self.state = State
  self.state:create()
  self.meal_selection = MealSelection
  self.meal_selection:setup(self.state)
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
  love.graphics.draw(self.background)
  -- Draw pawns
  self.state:draw()

  -- Draw GUI elements
  love.graphics.setColor(255, 255, 255, 255)
  if self.selected then
    Screen:draw(self.selected_overlay, self.selected.screen)
  end
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.setFont(self.font_normal)
  Screen:print(string.format("Day %i %s $%i", self.state.day, self.state:format_time(), 
    self.state.cash), Point.new(778, 10))
  Screen:print(self.state:name_stage(), Point.new(778, 74))
  Screen:print(string.format("#%i Eating", self.state:eating_count()), Point.new(8, 334))
  Screen:print(string.format("#%i Queued", self.state:line_count()), Point.new(8, 398))
  love.graphics.setFont(self.font_small)
  for k,v in ipairs(self.state.stock) do
    if k < 14 then
      Screen:print(tostring(v), Point.new(778, 330 + ((k - 1) * 32)))
    elseif k == 14 then
      Screen:print("...", Point.new(778, 330 + ((k - 1) * 32)))
    else
    end
  end
  local count, description = 0, nil
  for k,v in ipairs(self.state.tasks) do
    if count < 6 then
      description = v:description()
      if description then
        Screen:print(description, Point.new(778, 138 + ((count - 1) * 32)))
        count = count + 1
      end
    elseif count == 6 then
      Screen:print("...", Point.new(778, 138 + ((count - 1) * 32)))
      count = count + 1
    end
  end
  love.graphics.setColor(255, 255, 255, 255)
  if self.meal_selection.active then
    self.meal_selection:draw()
  elseif self.paused then
    love.graphics.setColor(128, 128, 128, 192)
    love.graphics.rectangle("fill", 228, 100, 568, 568)
  end
end

function InGame:update(dt)
  local stage = self.state:get_prep_stage()
  if stage then
    self.meal_selection:start(stage)
  elseif self.meal_selection.active then
    self.meal_selection:update(dt)
  elseif not self.paused then
    self.state.update(dt)
  end
end

function InGame:keypressed(key)
  if self.meal_selection.active then
    self.meal_selection:keypressed(key)
  elseif key == 'escape' or key == 'space' then
    self.paused = not self.paused
  end
end

function InGame:keyreleased(key)
end

function InGame:mousepressed(point, button)
  if self.meal_selection.active then
    self.meal_selection:mousepressed(point, button)
  elseif not self.paused then
    if button == 'l' then
      --if self.state.player:clicked(point) then
        --self.selected = self.state.player
      --else
        --self.selected = nil
      --end
    elseif button == 'r' then
      local coord = point:coordinate()
      if self.selected and not self.map:blocked(coord) and not self.map:occupant(coord) then
        self.selected:go(coord)
      end
    end
  end
end

function InGame:mousereleased(point, button)
  if self.meal_selection.active then
    self.meal_selection:mousereleased(point, button)
  end
end

