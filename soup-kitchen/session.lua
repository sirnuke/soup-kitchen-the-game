-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}
session.stages = { breakfast="breakfast", lunch="lunch", prepare="prepare", dinner="dinner",
  cleanup="cleanup", done="done" }

local function calc_stage(time)
  if time >= core.constants.day_end then
    return 'done'
  elseif  time >= core.constants.cleanup then
    return 'cleanup'
  elseif time >= core.constants.dinner then
    return 'dinner'
  elseif time >= core.constants.prepare then
    return 'prepare'
  elseif time >= core.constants.lunch then
    return 'lunch'
  else
    return 'breakfast'
  end
end

function session.draw()
  session.player:draw()
  for k,v in ipairs(session.line) do
    v:draw()
  end
  for k,v in ipairs(session.eating) do
    v:draw()
  end
end

function session.start()
  session.day = 0
  session.cash = core.constants.money_start
  session.stock = {}
  for i = 1,3 do table.insert(session.stock, StockClass.random('core')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('side')) end
  for i = 1,3 do table.insert(session.stock, StockClass.random('drink')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('desert')) end
  for i = 1,2 do table.insert(session.stock, StockClass.random('salad')) end

  session.player = PawnClass.new('player', core.constants.start_location.x,
    core.constants.start_location.y)
  session.employees = {}
  session.volunteers = {}
  session.new_day()
end

function session.update(dt)
  session.time = session.time + dt * core.constants.time_scale
  session.player:update(dt)
  local stage = calc_stage(session.time)
  local customer
  assert(session.stages[stage])
  if session.stage ~= stage then
    session.new_stage(stage)
  else
    if not map.occupant(core.constants.entry_location.x, core.constants.entry_location.y) then
      for k,v in ipairs(session.line) do
        if not v:spawned() then
          v:place()
          break
        end
      end
    end
  end
end

function session.new_stage(stage)
  session.customers = 0
  local count = 0
  if stage == 'breakfast' then
    count = homeless.spawn()
    print("Homeless count is", count)
  elseif stage == 'lunch' then
  elseif stage == 'prepare' then
  elseif stage == 'dinner' then
  elseif stage == 'cleanup' then
  else
    assert(false, string.format("Unhandled stage %s", stage))
  end
  session.stage = stage
  session.line = {}
  session.eating = {}
  for i = 0,count do
    table.insert(session.line, CustomerClass.new())
  end
end

function session.new_day()
  session.day = session.day + 1
  session.time = core.constants.day_start
  session.cash = session.cash - #session.employees * core.constants.employee_wage
  session.new_stage('breakfast')
  session.player:move(core.constants.start_location.x, core.constants.start_location.y)
  session.customers = {}
end

function session.format_time()
  if session.time > core.constants.day_end then 
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

function session.line_count()
  return #session.line
end

function session.eating_count()
  return #session.eating
end

