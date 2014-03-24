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
  self.slots[1] = MealSelectionSlot.new({'drink'})
  if meal == 'breakfast' then
    self.slots[2] = MealSelectionSlot.new({ 'side', 'core', 'dessert' })
    assert(#self.slots == constants.breakfast_end)
  elseif meal == 'lunch' then
    self.slots[2] = MealSelectionSlot.new({ 'dessert', 'salad' })
    self.slots[3] = MealSelectionSlot.new({ 'salad', 'side' })
    self.slots[4] = MealSelectionSlot.new({ 'side', 'core' })
    self.slots[5] = MealSelectionSlot.new({ 'core' })
  elseif meal == 'dinner' then
    self.slots[2] = MealSelectionSlot.new({ 'dessert' })
    self.slots[3] = MealSelectionSlot.new({ 'salad' })
    self.slots[4] = MealSelectionSlot.new({ 'side' })
    self.slots[5] = MealSelectionSlot.new({ 'core' })
  else
    assert(false, string.format("Unhandled meal type of %s", meal))
  end

  self.options = {}
  for id,stock in ipairs(session.stock) do
    if stock:ready() then
      table.insert(self.options, MealSelectionOption.new(stock))
    end
  end

  for id,serving in ipairs(map.actions.serving) do
    if self.slots[id] then self.slots[id]:set_selection(serving.stock_source) end
  end

  self.meal = meal
end

function meal_selection:enter()
  assert(not self.active)
  self.active = true
  assert(self.meal and self.slots and self.options)

  for id,serving in ipairs(map.actions.serving) do
    self.slots[id]:set_selection(serving.stock_source)
  end
end

function meal_selection:ok()
  assert(self.active)
  self.active = false
  -- TODO: Save selections
end

function meal_selection:cancel()
  assert(self.active)
  self.active = false
  -- TODO: Revert back to existing selections
end

function meal_selection:draw()
  assert(self.active)
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(self.overlay, 100, 100)

  love.graphics.setFont(ingame.font_small)
  for id,slot in ipairs(self.slots) do slot:draw(id) end
  for id,option in ipairs(self.options) do option:draw(id) end
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

