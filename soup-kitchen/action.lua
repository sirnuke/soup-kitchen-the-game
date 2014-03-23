-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ActionClass = {}
ActionClass.__index = ActionClass

function ActionClass.new(type, customer, volunteer)
  local instance = {}
  setmetatable(instance, ActionClass)
  instance.type = type
  if instance.customer then
    instance.customer = { x=customer.x,  y=customer.y  }
    assert(not map.blocked(customer.x, custumer.y))
    map.data[customer.y][customer.x].action = instance
  end
  assert(not map.blocked(volunteer.x, volunteer.y))
  instance.volunteer = { x=volunteer.x, y=volunteer.y }
  map.data[volunteer.y][volunteer.x].action = instance
  return instance
end

