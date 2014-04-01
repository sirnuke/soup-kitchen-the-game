-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ServingClass = {}
ServingClass.__index = ServingClass

function ServingClass.new(id, location, volunteer)
  local instance = {}
  setmetatable(instance, ServingClass)
  inherits(EquipmentClass.new(location, volunteer), instance)
  instance.id = id
  instance.stock = nil
  instance.quantity = nil
  instance.screen = location:screen()

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

