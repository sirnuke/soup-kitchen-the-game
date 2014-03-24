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

function meal_selection:enter(meal)
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
  self.meal = meal
end

function meal_selection:exit()
  self.active = false
  -- TODO: Save selections
end

function meal_selection:draw()
  assert(self.active)
  love.graphics.setColor(255, 255, 255, 224)
  love.graphics.draw(self.overlay, 100, 100)
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

