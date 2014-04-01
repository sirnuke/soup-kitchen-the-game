-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MealSelection = {}
MealSelection.__index = MealSelection
MealSelection.meals = { breakfast="breakfast", lunch="lunch", dinner="dinner" }

function MealSelection:setup()
  self.overlay = love.graphics.newImage("images/meal-selection/background.png")
  self.elements = {}
  self.elements.normal = love.graphics.newImage("images/meal-selection/normal.png")
  self.elements.invalid = love.graphics.newImage("images/meal-selection/invalid.png")
  self.elements.selected = love.graphics.newImage("images/meal-selection/selected.png")
  self.elements.used = love.graphics.newImage("images/meal-selection/used.png")
  self.button_ok = InteractableClass.new(Point.new(120, 628), 80, 20)
  self.button_cancel = InteractableClass.new(Point.new(220, 628), 80, 20)
  self.active = false
end

function MealSelection:destroy()
  self.overlay = nil
  self.elements = nil
end

function MealSelection:create_slots()
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

function MealSelection:start(meal)
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

function MealSelection:update_slots()
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


function MealSelection:enter()
  assert(not self.active)
  self.active = true
  assert(self.meal and self.slots and self.options)
  self.selected = nil
  self:update_slots()
end

function MealSelection:ok()
  assert(self.active)
  self.active = false
  for id,slot in ipairs(self.slots) do
    if slot.stock then
    end
  end
  -- TODO: Save selections
end

function MealSelection:cancel()
  assert(self.active)
  self.active = false
  -- TODO: Revert back to existing selections
end

function MealSelection:draw()
  assert(self.active)
  love.graphics.setColor(255, 255, 255, 224)
  Screen:draw(self.overlay, Point.new(100, 100))

  love.graphics.setFont(ingame.font_small)
  for id,slot in ipairs(self.slots) do slot:draw() end
  for id,option in ipairs(self.options) do option:draw() end
  -- TODO: Draw buttonzz
end

function MealSelection:update(dt)
  assert(self.active)
  self.button_ok:update()
  self.button_cancel:update()
  if self.button_ok:triggered() then
    Log("MealSelection:update", "Ok!")
    self:ok()
  elseif self.button_cancel:trigger() then
    Log("MealSelection:update", "Cancel!")
    self:cancel()
  end
  -- TODO: Update slots and options here
end

function MealSelection:keypressed(key)
  assert(self.active)
end

function MealSelection:mousepressed(point, button)
  assert(self.active)
  if button ~= 'l' then return end

  self.button_ok:mousepressed()
  self.button_cancel:mousepressed()
  -- TODO: Update slots and options here
end

function MealSelection:mousereleased(x, y, button)
  assert(self.active)
end

