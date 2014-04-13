-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

State = {}
State.stages = { start="start", breakfast="breakfast", prep_lunch="prep_lunch", lunch="lunch", 
  cook="cook", prep_dinner="prep_dinner", dinner="dinner", cleanup="cleanup", done="done" }
State.stage_order = { 'start', 'breakfast', 'prep_lunch', 'lunch', 'cook', 'prep_dinner', 'dinner', 'cleanup', 'done' }

function State:_calc_stage()
  for i = #self.stage_order,1,-1 do
    if self.time >= C.time[self.stage_order[i]] then
      return self.stage_order[i]
    end
  end
end

function State:draw()
  self.player:draw()
  for class,table in pairs(self.map.equipment) do
    for name,equipment in pairs(table) do
      equipment:draw()
    end
  end
  for i,customer in ipairs(self.line) do
    customer:draw()
  end
  for i,task in ipairs(self.tasks) do
    task:draw()
  end
end

function State:create()
  self.day = 0
  self.cash = C.money.initial
  self.stock = {}
  self.homeless = Homeless
  self.homeless:setup()
  self.map = MapClass
  self.prep_stage = nil
  self.map:create()
  local prepare = false
  for k,v in pairs(C.stock.start) do
    for i = 1,v do
      if i % 2 == 1 then prepare = true else prepare = false end
      table.insert(self.stock, StockClass.random(k, prepare))
    end
  end

  -- TODO: Create actual player class
  self.player = PawnClass.new(self.map, C.coordinates.player.start)
  self.player.image = love.graphics.newImage("images/pawns/player.png")
  self.employee = nil
  self.volunteers = {}
  self:new_day()
end

function State:update(dt)
  self.time = self.time + dt * C.scale.clock
  self.player:update(dt)

  local line = false
  if #self.line > 0 then line = true end

  local stage = self:_calc_stage()
  assert(self.stages[stage])
  if self.stage ~= stage then
    self:new_stage(stage)
  end
  for id,customer in next,self.line,nil do
    customer:update(dt)
    if customer.state == 'eating' then
      table.remove(self.line, id)
      table.insert(self.eating, customer)
    end
  end
  for id,customer in next,self.eating,nil do
    customer:update(dt)
  end
  for id,task in next,self.tasks,nil do
    task:update(dt)
    if task:done() then
      table.remove(self.tasks, id)
    end
  end
end

function State:new_stage(stage)
  print("New stage", stage)
  local count = 0
  if stage == 'start' then
    self.prep_stage = 'breakfast'
  elseif stage == 'breakfast' then
    count = homeless.spawn(stage)
    print("Homeless count is", count)
  elseif stage == 'prep_lunch' then
    self.prep_stage = 'lunch'
  elseif stage == 'lunch' then
    -- have everyone in line leave?
  elseif stage == 'cook' then
  elseif stage == 'prep_dinner' then
    self.prep_stage = 'dinner'
  elseif stage == 'dinner' then
  elseif stage == 'cleanup' then
  elseif stage == 'done' then
  else
    assert(false, string.format("Unhandled stage %s", stage))
  end
  for i = 1,count do
    table.insert(self.line, CustomerClass.new(stage))
  end
  self.stage = stage
end

function State:new_day()
  self.trash = 0
  self.day = self.day + 1
  self.time = C.time.start
  if self.employee then self.cash = self.cash - C.money.wage end
  self.line = {}
  self.eating = {}
  self.tasks = {}
  self.customers = {}
  self:new_stage('start')
  self.player:jump(C.coordinates.player.start)
  if self.employee then
    self.employee:jump(C.coordinates.employees.start)
  end
end

function State:add_trash(amount)
  self.trash = self.trash + amount
end

function State:format_time()
  if self.time >= C.time.done then 
    return "Late!"
  else
    local hour = math.floor((self.time - (self.time % 60)) / 60)
    local minute = math.floor(self.time % 60)
    local hstr, mstr
    if hour >= 13 then
      hour = hour - 12
    end
    if hour < 10 then
      hstr = string.format(" %i", hour)
    else
      hstr = string.format("%i", hour)
    end

    if minute < 10 then
      mstr = string.format("0%i", minute)
    else
      mstr = string.format("%i", minute)
    end
    return string.format("%s:%s", hstr, mstr)
  end
end

function State:name_stage()
  if self.time >= C.time.breakfast and self.time < C.time.breakfast + C.time.stage then
    return "Breakfast"
  elseif self.time >= C.time.lunch and self.time < C.time.lunch + C.time.stage then
    return "Lunch"
  elseif self.time >= C.time.cook and self.time < C.time.cook + C.time.stage then
    return "Cook"
  elseif self.time >= C.time.dinner and self.time < C.time.dinner + C.time.stage then
    return "Dinner"
  elseif self.time >= C.time.cleanup and self.time < C.time.cleanup + C.time.stage then
    return "Cleanup"
  else
    return ""
  end
end

function State:get_prep_stage()
  local prep = self.prep_stage
  self.prep_stage = nil
  return prep
end

function State:line_count()
  return #self.line
end

function State:eating_count()
  return #self.eating
end

