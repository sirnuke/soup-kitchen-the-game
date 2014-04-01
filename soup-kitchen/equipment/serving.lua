-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass

function ServingClass.new(id, location, customer, volunteer)
  assert(not map.blocked(customer))
  assert(not map.blocked(volunteer))
  assert(map.blocked(location))
  local instance = {}
  setmetatable(instance, ServingClass)
  instance.id = id
  instance.screen = {}
  instance.location = Coordinate.dup(location)
  instance.screen.location = instance:screen_calc(location)
  instance.customer = Coordinate.dup(customer)
  instance.screen.customer = instance:screen_calc(customer)
  instance.volunteer = Coordinate.dup(volunteer)
  instance.screen.volunteer = instance:screen_calc(volunteer)
  instance.next_stage = nil
  instance.stage = nil
  instance.stock = nil
  instance.quantity = nil

  return instance
end

function ServingClass:screen_calc(coord)
  return { x= (coord.x - 1) * constants.sizes.square, y= (coord.y - 1) * constants.sizes.square }
end

function ServingClass:set_stock(stock, quantity)
  self.stock = stock
  self.quantity = quantity
end

function ServingClass:next(stage)
  if self.id >= constants.breakfast_end and stage == 'breakfast' then
    return 'done'
  end
  return self.next_stage
end

function ServingClass:draw()
  local image, max = nil
  -- TODO: Draw quantity level image
  if not self.stock then
    --image = empty
  else
    max = constants.stock.server[self.stock.type]
    if self.quantity >= max  * .67 then
      -- image = mostly full
    elseif self.quantity >= max * .33 then
      -- image = getting low
    elseif self.quantity > 0 then
      -- image = low
    elseif self.quantity == 0 then
      -- image = empty
    end
  end
  if image then
    love.graphics.draw(image, self.screen_location.x, self.screen_location.y)
  end
end

