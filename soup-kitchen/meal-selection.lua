-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

meal_selection = {}
meal_selection.__index = meal_selection
meal_selection.meals = { breakfast="breakfast", lunch="lunch", dinner="dinner" }

function meal_selection:setup()
  self.overlay = love.graphics.newImage("images/ingame/meal-selection.png")
  self.active = false
end

function meal_selection:destroy()
  self.overlay = nil
end

function meal_selection:start(meal)
  assert(not self.active)
  self.active = true
  assert(self.meals[meal])
  self.slots = {}
  self.slots[1] = { 'drink' }
  if meal == 'breakfast' then
    self.slots[2] = { 'side', 'core', 'dessert' }
    assert(#self.slots == constants.breakfast_end)
  elseif meal == 'lunch' then
    self.slots[2] = { 'dessert', 'salad' }
    self.slots[3] = { 'salad', 'side' }
    self.slots[4] = { 'side', 'core' }
    self.slots[5] = { 'core' }
  elseif meal == 'dinner' then
    self.slots[2] = { 'dessert' }
    self.slots[3] = { 'salad' }
    self.slots[4] = { 'side' }
    self.slots[5] = { 'core' }
  else
    assert(false, string.format("Unhandled meal type of %s", meal))
  end
  self.choices = {}
  for k,v in ipairs(session.stock) do
    if v:ready() then
      table.insert(self.choices, v)
    end
  end
  self.selections = {}
  for k,v in ipairs(map.actions.serving) do
    if v.stock_source then
      self.selections[k] = v.stock_source
    end
  end
  self.meal = meal
end

function meal_selection:enter()
  assert(not self.active)
  self.active = true
  self.selections = {}
  assert(self.meal and self.slots)
  for k,v in ipairs(map.actions.serving) do
    if v.stock_source then
      self.selections[k] = v.stock_source
    end
  end
end

function meal_selection:exit()
  assert(self.active)
  self.active = false
  -- TODO: Save selections
end

function meal_selection:draw()
  assert(self.active)
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(self.overlay, 100, 100)

  love.graphics.setColor(0, 0, 0, 224)
  love.graphics.setFont(ingame.font_small)
  love.graphics.print("hello", 100 + 26, 100 + 26)
  love.graphics.print("world!", 100 + 428, 100 + 26)
end

function meal_selection:update(dt)
  assert(self.active)
end

function meal_selection:keypressed(key)
  assert(self.active)
end

function meal_selection:mousepressed(x, y, button)
  assert(self.active)
end

function meal_selection:mousereleased(x, y, button)
  assert(self.active)
end

