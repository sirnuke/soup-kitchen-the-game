-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ActionClass = {}
ActionClass.__index = ActionClass
ActionClass.types = {
  drinks='drinks', food1='food1', food2='food2', food3='food3', food4='food4',
  cleaning1='cleaning1', cleaning2='cleaning2', prepare1='prepare1', prepare2='prepare2',
  prepare3='prepare3', prepare4='prepare4', prepare5='prepare5', prepare6='prepare6',
  storage1='storage1', storage2='storage2', storage3='storage3', trash='trash'
}

function ActionClass.new(type, customer, volunteer)
  local instance = {}
  assert(ActionClass.types[type])
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

