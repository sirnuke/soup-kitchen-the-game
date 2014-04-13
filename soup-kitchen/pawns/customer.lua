-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

CustomerClass = {}
CustomerClass.__index = CustomerClass
CustomerClass.image = nil

function CustomerClass.new(map, stage)
  if not CustomerClass.image then
    CustomerClass.image = love.graphics.newImage("images/pawns/customer.png")
  end

  local instance = {}
  setmetatable(instance, CustomerClass)
  inherits(PawnClass.new(map, nil), instance)
  instance.equipment = nil
  instance.stage = stage
  instance.tray = nil
  instance.task = nil
  return instance
end

function CustomerClass:update(dt)
  self:move(dt)
  if not self.task then
    assert(not self:spawned())
    if not map:occupied(C.coordinates.customer.entrance) then
      self:enter(C.coordinates.customer.entrance)
      self.task = GetFodTaskClass.new(map.equipment.dispensing.trays, self)
    end
  elseif self:arrived() then
    self.task:update(dt)
  end
end

