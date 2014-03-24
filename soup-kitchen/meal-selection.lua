-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

meal_selection = {}
meal_selection.__index = meal_selection
meal_selection.meals = { breakfast="breakfast", lunch="lunch", dinner="dinner" }

function meal_selection:setup()
  self.overlay = love.graphics.newImage("images/meal-selection/background.png")
  self.elements = {}
  self.elements.normal = love.graphics.newImage("images/meal-selection/normal.png")
  self.elements.invalid = love.graphics.newImage("images/meal-selection/invalid.png")
  self.elements.selected = love.graphics.newImage("images/meal-selection/selected.png")
  self.elements.used = love.graphics.newImage("images/meal-selection/used.png")
  self.active = false
end

function meal_selection:destroy()
  self.overlay = nil
  self.elements = nil
end

function meal_selection:create_slots()
  self.slots = {}
  self.slots[1] = MealSelectionSlot.new(1, {'drink'})
  if self.meal == 'breakfast' then
    self.slots[2] = MealSelectionSlot.new(2, { 'side', 'core', 'dessert' })
    assert(#self.slots == constants.breakfast_end)
  elseif self.meal == 'lunch' then
    self.slots[2] = MealSelectionSlot.new(2, { 'dessert', 'salad' })
    self.slots[3] = MealSelectionSlot.new(3, { 'salad', 'side' })
    self.slots[4] = MealSelectionSlot.new(4, { 'side', 'core' })
    self.slots[5] = MealSelectionSlot.new(5, { 'core' })
  elseif self.meal == 'dinner' then
    self.slots[2] = MealSelectionSlot.new(2, { 'dessert' })
    self.slots[3] = MealSelectionSlot.new(3, { 'salad' })
    self.slots[4] = MealSelectionSlot.new(4, { 'side' })
    self.slots[5] = MealSelectionSlot.new(5, { 'core' })
  else
    assert(false, string.format("Unhandled meal type of %s", self.meal))
  end
end

function meal_selection:start(meal)
  assert(not self.active)
  self.active = true
  assert(self.meals[meal])
  self.meal = meal

  self:create_slots()

  self.selected = nil

  self.options = {}
  for id,stock in ipairs(session.stock) do
    if stock:ready() then
      table.insert(self.options, MealSelectionOption.new(#self.options + 1, stock))
    end
  end

  self:update_slots()
end

function meal_selection:update_slots()
  for id,option in ipairs(self.options) do
    option.slot = nil
  end
  for id,serving in ipairs(map.actions.serving) do
    if self.slots[id] then
      self.slots[id]:set_selection(serving.stock_source)
      for i,option in ipairs(self.options) do
        if option.stock == serving.stock_source then
          option.slot = self.slots[id]
        end
      end
    end
  end
end


function meal_selection:enter()
  assert(not self.active)
  self.active = true
  assert(self.meal and self.slots and self.options)
  self.selected = nil
  self:update_slots()
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
  for id,slot in ipairs(self.slots) do slot:draw() end
  for id,option in ipairs(self.options) do option:draw() end
end

function meal_selection:update(dt)
  assert(self.active)
end

function meal_selection:keypressed(key)
  assert(self.active)
end

function meal_selection:mousepressed(x, y, button)
  assert(self.active)
  if button ~= 'l' then return end

  if self.selected then
    for id,slot in ipairs(self.slots) do
      if slot:inbounds(x, y) then
        if self.selected.slot then
          self.selected.slot:set_selection(nil)
        end
        for id,option in ipairs(self.options) do
          if option.slot == slot then option.slot = nil end
        end
        self.selected.slot = slot
        slot:set_selection(self.selected.stock)
        self.selected = nil
        return
      end
    end
  end
  self.selected = nil
  for id,option in ipairs(self.options) do
    if option:inbounds(x, y) then
      self.selected = option
      break
    end
  end
end

function meal_selection:mousereleased(x, y, button)
  assert(self.active)
end

