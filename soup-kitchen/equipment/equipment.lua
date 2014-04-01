-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

EquipmentClass = {}
EquipmentClass.__index = EquipmentClass

function EquipmentClass.new(location, hotspot)
  assert(location, hotspot)
  local instance = {}
  setmetatable(instance, EquipmentClass)
  instance.location = location
  instance.hotspot = hotspot
  return instance
end

function EquipmentClass:draw()
  assert(false, "EquipmentClass instance doesn't override draw()")
end

