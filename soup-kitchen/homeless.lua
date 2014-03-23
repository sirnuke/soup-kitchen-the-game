-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

homeless = {}

function homeless.spawn()
  if not homeless.demand then
    homeless.demand = core.constants.homeless_need
  end
end

function homeless.complete(served)
end

