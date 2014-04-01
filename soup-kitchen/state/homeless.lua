-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Homeless = {}

-- demand defaults to the Constant demand.initial
function Homeless:setup(demand)
  self.demand = demand or C.demand.initial
end

function Homeless:spawn(stage)
  local demand, scale = 0, C.demand[stage]
  assert(scale, string.format("Unable to find demand scale for %s", stage))
  demand = math.floor(love.math.randomNormal(10, self.demand * scale))
  if demand <= 0 then
    print("Warning, bad demand of", demand)
    demand = 1
  end
  return demand
end

function Homeless:complete(served)
  local delta = self.demand - served
  self.demand = self.demand + love.math.randomNormal(delta / 5, delta)
  print("New demand is", self.demand)
end

