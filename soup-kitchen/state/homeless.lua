-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

HomelessClass = {}
HomelessClass.__index = HomelessClass

-- demand defaults to the Constant demand.initial
function HomelessClass.new(demand)
  local instance = {}
  setmetatable(instance, HomelessClass)
  instance.demand = demand or C.demand.initial
  return instance
end

function HomelessClass:spawn(stage)
  local demand, scale = 0, C.demand[stage]
  assert(scale, string.format("Unable to find demand scale for %s", stage))
  demand = math.floor(love.math.randomNormal(10, self.demand * scale))
  if demand <= 0 then
    print("Warning, bad demand of", demand)
    demand = 1
  end
  return demand
end

function HomelessClass:complete(served)
  local delta = self.demand - served
  self.demand = self.demand + love.math.randomNormal(delta / 5, delta)
  print("New demand is", self.demand)
end

