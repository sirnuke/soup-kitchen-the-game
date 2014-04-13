-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass

function ServingClass.new(type, location, volunteer)
  local instance = EquipmentClass.new('volunteer', type, location, volunteer)
  setmetatable(instance, ServingClass)
  inherits(EquipmentClass, instance)
  instance.stock = nil
  instance.quantity = nil
  return instance
end

function ServingClass:restock(stock, quantity)
  self.stock = stock
  self.quantity = quantity
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
  if image then Screen:draw(image, self.screen) end
end

