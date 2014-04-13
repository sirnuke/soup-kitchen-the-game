-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PlayerClass = {}
PlayerClass.__index = PlayerClass

function PlayerClass.new(map) 
  if not PlayerClass.image then
    PlayerClass.image = love.graphics.newImage("images/pawns/player.png")
  end

  local instance = PawnClass.new(map, nil)
  setmetatable(instance, PlayerClass)
  inherits(PawnClass, instance)
  return instance
end

