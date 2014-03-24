-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass
ServingClass.states = { inactive='inactive', active='active', halted='halted' }

function ServingClass.new(id, location, customer, volunteer)
  assert(not map.blocked(customer))
  assert(not map.blocked(volunteer))
  assert(map.blocked(location))
  local instance = {}
  setmetatable(instance, ServingClass)
  instance.id = id
  instance.location = Coordinate.dup(location)
  instance.screen_location = instance:screen(location)
  instance.customer = Coordinate.dup(customer)
  instance.screen_customer = instance:screen(customer)
  instance.volunteer = Coordinate.dup(volunteer)
  instance.screen_volunteer = instance:screen(volunteer)
  instance.next_stage = nil
  instance.stock = nil
  instance.quantity = nil
  instance.progress = 0
  instance.state = 'inactive'
  return instance
end

function ServingClass:screen(coord)
  return { x= (coord.x - 1) * constants.sizes.square, y= (coord.y - 1) * constants.sizes.square }
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
  if self.id >= constants.breakfast_end and stage == 'breakfast' then
    return 'done'
  end
  return self.next_stage
end

function ServingClass:draw(stage, line)
  assert(stage)
  local customer, volunteer = map.occupant(self.customer), map.occupant(self.volunteer)
  local image = nil
  if self.id > constants.breakfast_end and (stage == 'breakfast' or stage == 'start') then
    return
  end
  if stage == 'breakfast' or stage == 'lunch' or stage == 'dinner' or line then
    if not customer then
      image = ActionClass.images.potential
    elseif customer.action == self and customer:arrived() then
      if not volunteer or not volunteer:arrived() then
        image = ActionClass.images.halted
      else
        image = ActionClass.images.active
      end
    else
      image = ActionClass.images.halted
    end
    love.graphics.draw(image, self.screen_customer.x, self.screen_customer.y)
    love.graphics.draw(image, self.screen_volunteer.x, self.screen_volunteer.y)
  elseif stage == "start" or stage == "prepare" then
    if not volunteer or not volunteer:arrived() then
      image = ActionClass.images.halted
    else
      image = ActionClass.images.active
    end
    love.graphics.draw(image, self.screen_volunteer.x, self.screen_volunteer.y)
  end
end

