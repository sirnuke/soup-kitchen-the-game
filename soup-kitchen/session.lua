-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}
session.stages = { start="start", breakfast="breakfast", prep_lunch="prep_lunch", lunch="lunch", 
  cook="cook", prep_dinner="prep_dinner", dinner="dinner", cleanup="cleanup", done="done" }
session.stage_order = { 'start', 'breakfast', 'prep_lunch', 'lunch', 'cook', 'prep_dinner', 'dinner', 'cleanup', 'done' }

local function calc_stage(time)
  for i = #session.stage_order,1,-1 do
    if time >= constants.time[session.stage_order[i]] then
      return session.stage_order[i]
    end
  end
end

function session.draw()
  session.player:draw()
  for class,table in pairs(map.actions) do
    for name,action in pairs(table) do
      action:draw()
    end
  end
  for k,v in ipairs(session.line) do
    v:draw()
  end
end

function session.start()
  session.day = 0
  session.cash = constants.money.initial
  session.stock = {}
  homeless.setup()
  local prepare = false
  for k,v in pairs(constants.stock.start) do
    for i = 1,v do
      if i % 2 == 1 then prepare = true else prepare = false end
      table.insert(session.stock, StockClass.random(k, prepare))
    end
  end

  session.player = PawnClass.new('player', constants.coords.start)
  session.employee = nil
  session.volunteers = {}
  session.tasks = {}
  session.new_day()
end

function session.update(dt)
  session.tasks = {}
  session.time = session.time + dt * constants.scale.clock
  session.player:update(dt)
  local line = false
  if #session.line > 0 then
    line = true
  end
  local stage = calc_stage(session.time)
  local customer
  assert(session.stages[stage])
  if session.stage ~= stage then
    session.new_stage(stage)
  end
  for k,v in next,session.line,nil do
    v:update(dt)
    if v.state == 'eating' then
      table.remove(session.line, k)
      table.insert(session.eating, v)
    end
  end
  -- TODO: Iterate over session.line, if state==eating, put them in eating
  for k,v in next,session.eating,nil do
    v:update(dt)
  end

  for class,table in pairs(map.actions) do
    for name,action in pairs(table) do
      action:update(dt, line)
    end
  end
end

function session.new_stage(stage)
  print("New stage", stage)
  local count = 0
  if stage == 'start' then
    meal_selection:start('breakfast')
  elseif stage == 'breakfast' then
    count = homeless.spawn(stage)
    print("Homeless count is", count)
  elseif stage == 'prep_lunch' then
    meal_selection:start('lunch')
  elseif stage == 'lunch' then
    -- have everyone in line leave?
  elseif stage == 'cook' then
  elseif stage == 'prep_dinner' then
    menu_selection:start('dinner')
  elseif stage == 'dinner' then
  elseif stage == 'cleanup' then
  elseif stage == 'done' then
  else
    assert(false, string.format("Unhandled stage %s", stage))
  end
  for i = 1,count do
    table.insert(session.line, CustomerClass.new(stage))
  end
  for class,table in pairs(map.actions) do
    for name,action in pairs(table) do
      action:new_stage(stage)
    end
  end
  session.stage = stage
end

function session.new_day()
  session.trash = 0
  session.day = session.day + 1
  session.time = constants.time.start
  if session.employee then
    session.cash = session.cash - constants.money.wage
  end
  session.line = {}
  session.eating = {}
  session.tasks = {}
  session.customers = {}
  session.new_stage('start')
  session.player:move(constants.coords.start)
  if session.employee then
    session.employee:move(constants.coords.employee)
  end
end

function session.add_trash(amount)
  session.trash = session.trash + amount
end

function session.format_time()
  if session.time >= constants.time.done then 
    return "Late!"
  else
    local hour = math.floor((session.time - (session.time % 60)) / 60)
    local minute = math.floor(session.time % 60)
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

function session.name_stage()
  if session.time >= constants.time.breakfast 
    and session.time < constants.time.breakfast + constants.time.stage then
    return "Breakfast"
  elseif session.time >= constants.time.lunch
    and session.time < constants.time.lunch + constants.time.stage then
    return "Lunch"
  elseif session.time >= constants.time.cook
    and session.time < constants.time.cook + constants.time.stage then
    return "Cook"
  elseif session.time >= constants.time.dinner
    and session.time < constants.time.dinner + constants.time.stage then
    return "Dinner"
  elseif session.time >= constants.time.cleanup
    and session.time < constants.time.cleanup + constants.time.stage then
    return "Cleanup"
  else
    return ""
  end
end

function session.line_count()
  return #session.line
end

function session.eating_count()
  return #session.eating
end

