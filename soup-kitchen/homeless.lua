-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

homeless = {}

function homeless.setup()
  homeless.demand = constants.demand.initial
end

function homeless.spawn(stage)
  local demand, scale = 0, constants.demand[stage]
  assert(scale, string.format("Unable to find demand scale for %s", stage))
  demand = math.floor(love.math.randomNormal(10, homeless.demand * scale))
  if demand <= 0 then
    print("Warning, bad demand of", demand)
    demand = 1
  end
  return demand
end

function homeless.complete(served)
  local delta = homeless.demand - served
  homeless.demand = homeless.demand + love.math.randomNormal(delta / 5, delta)
  print("New demand is", homeless.demand)
end

