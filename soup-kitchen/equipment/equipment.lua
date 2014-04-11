-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

EquipmentClass = {}
EquipmentClass.__index = EquipmentClass

function EquipmentClass.new(class, type, location, hotspot)
  assert(class == 'customer' or class == 'volunteer',
    string.format("Unknown equipment class of %s", class))
  assert(type and location and hotspot)
  local instance = {}
  setmetatable(instance, EquipmentClass)
  instance.class = class
  instance.type = type
  instance.location = location
  instance.hotspot = hotspot
  instance.screen = location:screen()
  return instance
end

function EquipmentClass:draw()
  --assert(false, "EquipmentClass instance doesn't override draw()")
end

