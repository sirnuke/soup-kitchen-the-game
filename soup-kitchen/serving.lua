-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass
ServingClass.serving_states = { potential='potential', active='active', halted='halted',
  inactive='inactive' }
ServingClass.stocking_states = { full='full', medium='medium', low='low', empty='empty',
  inactive='inactive' }

ServingClass.states = { stock='stock', serve='serve', clean='clean', inactive='inactive' }

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
  instance.stage = nil
  instance.stock_source = nil
  instance.quantity = nil
  --instance.progress = 0

  --instance.state = 'inactive'

  --instance.tasks = {}
  --instance.tasks.stocking = 'inactive'
  --instance.tasks.serving = 'inactive'

  return instance
end

function ServingClass:screen(coord)
  return { x= (coord.x - 1) * constants.sizes.square, y= (coord.y - 1) * constants.sizes.square }
end

--function ServingClass:new_stage(stage) 
  --assert(stage)
  --self.stage = stage
--end

function ServingClass:set_stock(stock_source, quantity)
  self.stock_source = stock_source
  self.quantity = quantity
end

function ServingClass:reset()
  self.progress = 0
end

--function ServingClass:update(dt, line)
  --local customer, volunteer = map.occupant(self.customer), map.occupant(self.volunteer)

  --if self.id > constants.breakfast_end 
    --and (self.stage == 'start' or self.stage == 'breakfast') then
    --self.tasks.stocking = 'inactive'
    --self.tasks.serving = 'inactive'
    --return
  --end

  --if not self.stock_source or self.stage == 'cleanup' or self.stage == 'done' then
    --self.tasks.stocking = 'inactive'
  --else
    --if self.quantity >= constants.stock.serve[self.stock_source.type] * .67 then
      --self.tasks.stocking = 'full'
    --elseif self.quantity >= constants.stock.server[self.stock_source.type] * .33 then
      --self.tasks.stocking = 'medium'
    --elseif self.quantity > 0 then
      --self.tasks.stocking = 'low'
    --else
      --self.tasks.stocking = 'empty'
    --end
  --end

  --if not line then
    --self.tasks.serving = 'inactive'
    --return
  --end

  --if not customer or customer.action ~= self then
    --self.tasks.serving = 'potential'
    --return
  --end

  --if not volunteer or not volunteer:arrived() then
    --table.insert(session.tasks, TaskClass.new('serving', 
    --string.format("Need help at (%i,%i)", self.volunteer.x, self.volunteer.y)))
    --self.tasks.serving = 'halted'
  --elseif customer:arrived() then
    --self.tasks.serving = 'active'
    --self.progress = self.progress + dt * constants.scale.work
  --end
--end

--function ServingClass:done()
  --if self.progress >= constants.max_progress then
    --return true
  --else
    --return false
  --end
--end

function ServingClass:next(stage)
  if self.id >= constants.breakfast_end and stage == 'breakfast' then
    return 'done'
  end
  return self.next_stage
end

function ServingClass:draw()
  local image = nil
  -- TODO: Draw quantity level image
  --assert(ServingClass.serving_states[self.tasks.serving])
  --assert(ServingClass.stocking_states[self.tasks.stocking])

  --if self.tasks.stocking ~= 'inactive' then
    --image = ActionClass.images.potential
  --end
  --if image then
    --love.graphics.draw(image, self.screen_volunteer.x, self.screen_volunteer.y)
  --end

  --image = nil
  --if self.tasks.serving == 'potential' then
    --image = ActionClass.images.potential
  --elseif self.tasks.serving == 'active' then
    --image = ActionClass.images.active
  --elseif self.tasks.serving == 'halted' then
    --image = ActionClass.images.halted
  --end
  --if image then 
    --love.graphics.draw(image, self.screen_customer.x, self.screen_customer.y)
    --love.graphics.draw(image, self.screen_volunteer.x, self.screen_volunteer.y)
  --end
end

