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
  end
  instance.volunteer = { x=volunteer.x, y=volunteer.y }
end

