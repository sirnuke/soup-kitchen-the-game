-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

homeless = {}

function homeless.spawn()
  if not homeless.demand then
    homeless.demand = constants.homeless_need
  end
  return math.floor(love.math.randomNormal(10, homeless.demand))
end

function homeless.complete(served)
  local delta = homeless.demand - served
  homeless.demand = homeless.demand + love.math.randomNormal(delta / 5, delta)
  print("New demand is", homeless.demand)
end

