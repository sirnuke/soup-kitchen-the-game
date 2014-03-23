-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}

function session.start()
  session.day = 0
  session.cash = core.constants.money_start
  session.stock = {}
  for i = 1,3 do table.insert(session.stock, StockClass.random('core')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('side')) end
  for i = 1,3 do table.insert(session.stock, StockClass.random('drink')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('desert')) end
  for i = 1,2 do table.insert(session.stock, StockClass.random('salad')) end

  session.player = PawnClass.new('player', 5, 11)
  session.employees = {}
  session.volunteers = {}
  session.new_day()
end

function session.update(dt)
  session.time = session.time + dt * core.constants.time_scale
  session.player:update(dt)
end

function session.new_day()
  session.day = session.day + 1
  session.time = core.constants.day_start
  session.cash = session.cash - #session.employees * core.constants.employee_wage
end

function session.format_time()
  if session.time > core.constants.day_end then 
    return "Late!"
  else
    local hour, minute = (session.time - (session.time % 60)) / 60, session.time % 60
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
  -- TODO: Dis
  return 0
end

function session.eating_count()
  -- TODO: Dis
  return 0
end

