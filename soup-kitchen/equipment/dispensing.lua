-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

DispensingClass = {}
DispensingClass.__index = DispensingClass

function DispensingClass.new(type, location, customer)

  local instance = {}
  setmetatable(instance, DispensingClass)
  inherits(EquipmentClass.new(location, customer), instance)
  instance.type = type
  instance.location = location
  instance.customer = customer
  instance.screen = location:screen()
  return instance
end

