-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

StageClass = {}
StageClass.__index = StageClass
StageClass.stages = { prepare='prepare', serve='serve', clean='clean', done='done' }

function StageClass.new(id)
  assert(C.stages[id], string.format("Unknown stage %s", id))
  local instance = {}
  setmetatable(instance, StageClass)
  instance.C = C.stages[id]
  instance.id = id
  return instance
end

function StageClass:stage(time)
  assert(time >= self.C.start)
  if time < self.C.serve then
    return 'prepare'
  elseif time < self.C.clean then
    return 'serve'
  elseif time < self.C.done then
    return 'clean'
  else
    return 'done'
  end
end

