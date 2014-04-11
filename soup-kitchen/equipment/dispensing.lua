-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

DispensingClass = {}
DispensingClass.__index = DispensingClass

function DispensingClass.new(type, location, customer)

  local instance = {}
  setmetatable(instance, DispensingClass)
  inherits(EquipmentClass.new('customer', type, location, customer), instance)
  return instance
end

function DispensingClass:draw()
  -- TODO: dis
end

