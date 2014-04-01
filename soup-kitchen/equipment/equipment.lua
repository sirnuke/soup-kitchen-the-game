-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

ActionClass = {}
ActionClass.__index = ActionClass
ActionClass.types = {
  cleaning1='cleaning1', cleaning2='cleaning2', cleaning3='cleaning3', prepare1='prepare1', 
  prepare2='prepare2', prepare3='prepare3', prepare4='prepare4', prepare5='prepare5',
  prepare6='prepare6', storage1='storage1', storage2='storage2', storage3='storage3',
  trash='trash'
}

function ActionClass.setup()
  ActionClass.images = {}
  ActionClass.images.active = love.graphics.newImage("images/actions/active.png")
  ActionClass.images.halted = love.graphics.newImage("images/actions/halted.png")
  ActionClass.images.potential = love.graphics.newImage("images/actions/potential.png")
end

function ActionClass.new(type, customer, volunteer)
  local instance = {}
  assert(ActionClass.types[type])
  setmetatable(instance, ActionClass)
  instance.type = type
  if customer then
    instance.customer = Coordinate.new(customer.x, customer.y)
    assert(not map.blocked(customer))
    map.set_action(customer, instance)
  end
  assert(not map.blocked(volunteer))
  instance.volunteer = Coordinate.new(volunteer.x, volunteer.y)
  map.set_action(volunteer, instance)
  instance.progress = 0
  return instance
end

function ActionClass:new_stage(stage)
  self.stage = stage
end

function ActionClass:draw()
end


function ActionClass:update(dt, line)
  local customer, volunteer
  if self.customer then customer = map.occupant(self.customer) end
  if self.volunteer then volunteer = map.occupant(self.volunteer) end
  if self.type == 'cleaning1' then
  elseif self.type == 'cleaning2' then
  elseif self.type == 'cleaning3' then
  elseif self.type == 'prepare1' then
  elseif self.type == 'prepare2' then
  elseif self.type == 'prepare3' then
  elseif self.type == 'prepare4' then
  elseif self.type == 'prepare5' then
  elseif self.type == 'prepare6' then
  elseif self.type == 'storage1' then
  elseif self.type == 'storage2' then
  elseif self.type == 'storage3' then
  elseif self.type == 'trash' then
  else
    assert(false, string.format("Unhandled action type of %s", self.type))
  end
end

function ActionClass:done()
  if self.progress >= constants.max_progress then
    return true
  else
    return false
  end
end
