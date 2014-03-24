-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass

function ServingClass.new(location, customer, volunteer)
  assert(not map.blocked(customer))
  assert(not map.blocked(volunteer))
  assert(map.blocked(location))
  local instance = {}
  setmetatable(instance, ServingClass)
  instance.location = Coordinate.dup(location)
  instance.customer = Coordinate.dup(customer)
  instance.volunteer = Coordinate.dup(volunteer)
  instance.next_stage = nil
  instance.stock = nil
  instance.quantity = nil
  instance.progress = 0
  return instance
end

function ServingClass:reset()
  self.progress = 0
end

function ServingClass:update(dt)
  local customer, volunteer = map.occupant(self.customer), map.occupant(self.volunteer)
  if not customer or customer.action ~= self then return end
  if not volunteer or not volunteer:arrived() then
    table.insert(session.tasks, TaskClass.new('serving', 
    string.format("Need help at (%i,%i)", self.volunteer.x, self.volunteer.y)))
  elseif customer:arrived() then
    self.progress = self.progress + dt * constants.scale.work
  end
end

function ServingClass:done()
  if self.progress >= constants.max_progress then
    return true
  else
    return false
  end
end

function ServingClass:next(stage)
  assert(self.next_stage)
  assert(stage)
  if self == map.actions.serving[2] and stage == 'breakfast' then
    return 'done'
  end
  return self.next_stage
end

