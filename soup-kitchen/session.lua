-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}
session.stages = { start="start", breakfast="breakfast", lunch="lunch", prepare="prepare", 
  dinner="dinner", cleanup="cleanup", done="done" }

local function calc_stage(time)
  if time >= constants.time.close then
    return 'done'
  elseif  time >= constants.time.cleanup then
    return 'cleanup'
  elseif time >= constants.time.dinner then
    return 'dinner'
  elseif time >= constants.time.prepare then
    return 'prepare'
  elseif time >= constants.time.lunch then
    return 'lunch'
  elseif time >= constants.time.breakfast then
    return 'breakfast'
  else
    return 'start'
  end
end

function session.draw()
  session.player:draw()
  for k,v in ipairs(session.line) do
    v:draw()
  end
end

function session.start()
  session.day = 0
  session.cash = constants.money.initial
  session.stock = {}
  homeless.setup()
  for k,v in pairs(constants.stock.start) do
    for i = 1,v do
      table.insert(session.stock, StockClass.random(k))
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
      action:update(dt)
    end
  end
end

function session.new_stage(stage)
  print("New stage", stage)
  local count = 0
  if stage == 'start' then
  elseif stage == 'breakfast' then
    count = homeless.spawn(stage)
    print("Homeless count is", count)
  elseif stage == 'lunch' then
    -- have everyone in line leave?
  elseif stage == 'prepare' then
  elseif stage == 'dinner' then
  elseif stage == 'cleanup' then
  else
    assert(false, string.format("Unhandled stage %s", stage))
  end
  for i = 1,count do
    table.insert(session.line, CustomerClass.new(stage))
  end
  session.stage = stage
end

function session.new_day()
  session.day = session.day + 1
  session.time = constants.time.start
  session.cash = session.cash - #session.employees * constants.money.wage
  session.line = {}
  session.eating = {}
  session.tasks = {}
  session.customers = {}
  session.new_stage('start')
  session.player:move(constants.coords.start)
end

function session.format_time()
  if session.time >= constants.time.close then 
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
  elseif session.time >= constants.time.prepare
    and session.time < constants.time.prepare + constants.time.stage then
    return "Prepare"
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

