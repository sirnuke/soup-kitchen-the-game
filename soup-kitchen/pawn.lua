-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass
PawnClass.types = { player='player', employee='employee', volunteer='volunteer',
  customer='customer' }
PawnClass.images = { }

function PawnClass.new(type, coord)
  assert(PawnClass.types[type])

  if not PawnClass.pathfinding then
    PawnClass.pathfinding = { }
    PawnClass.pathfinding.map = { }

    for y = 1,constants.sizes.map.h do
      local row = { }
      for x = 1,constants.sizes.map.w do
        table.insert(row, nil)
      end
      table.insert(PawnClass.pathfinding.map, row)
    end
  end

  if type == 'player' then
    if not PawnClass.images.player then
      PawnClass.images.player = love.graphics.newImage("images/pawns/player.png")
    end
  elseif type == 'employee' then
  elseif type == 'volunteer' then
  elseif type == 'customer' then
    if not PawnClass.images.customer then
      PawnClass.images.customer = love.graphics.newImage("images/pawns/customer.png")
    end
  else
    assert(false, string.format("Unhandled pawn type %s", type))
  end


  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.action = nil
  instance.left = false
  if coord == 'enter' then
    assert(not map.occupant(constants.coords.entrance))
    instance.position = map.position(constants.coords.entrance)
    instance.position.x = instance.position.x - constants.sizes.square
    instance.coordinate = Coordinate.dup(constants.coords.entrance)
    instance.path = { Coordinate.dup(constants.coords.entrance) }
    instance.destination = map.position(constants.coords.entrance)
  else
    assert(not map.blocked(coord))
    assert(not map.occupant(coord))
    instance.position = map.position(coord)
    instance.coordinate = Coordinate.new(coord.x, coord.y)
    instance.path = nil
    instance.destination = nil
  end

  map.set_occupant(instance.coordinate, instance)
  instance:set_screen()

  return instance
end

function PawnClass:draw()
  love.graphics.draw(PawnClass.images[self.type], self.screen.x, self.screen.y)
end

function PawnClass:set_screen()
  self.screen = {}
  self.screen.x = self.position.x - (constants.sizes.square - constants.sizes.pawn) / 2
  self.screen.y = self.position.y - (constants.sizes.square - constants.sizes.pawn) / 2
end

function PawnClass:move(coord)
  self.path = nil
  self.destination = nil
  self.cordinates = Coordinate.new(coord.x, coord.y)
  self.position = map.position(coord)
  self:set_screen()
end

function PawnClass:arrived()
  if self.destination then
    return false
  else
    return true
  end
end

function PawnClass:pathfind(coord)
  local current = map.coordinate(self.position.x, self.position.y)

  PawnClass.pathfinding.map[current.y][current.x] = true

  local queue = { current }

  print(string.format("Pathfinding from (%i,%i) to (%i,%i)", self.coordinate.x,
    self.coordinate.y, coord.x, coord.y))

  while #queue > 0 and queue[1] ~= coord do
    --print("Getting neighbors of ", queue[1].x, queue[1].y)
    for k,v in ipairs(map.get_neighbors(queue[1])) do
      --print("Checking", v.x, v.y)
      if not PawnClass.pathfinding.map[v.y][v.x] then
        PawnClass.pathfinding.map[v.y][v.x] = Coordinate.new(queue[1].x, queue[1].y) 
        table.insert(queue, Coordinate.new(v.x, v.y))
      end
    end
    table.remove(queue, 1)
  end
  assert(#queue > 0, "Couldn't find a path!")
  assert(queue[1] == coord, "Top of queue should be the end")
  self.path = { Coordinate.new(coord.x, coord.y) }
  local square = PawnClass.pathfinding.map[coord.y][coord.x]
  --print("Path ends up at ", x, y, type(square))
  while type(square) ~= "boolean" do
    assert(type(square) == "table")
    table.insert(self.path, Coordinate.new(square.x, square.y))
    --print("Looking up parent of ", square.x, square.y)
    square = PawnClass.pathfinding.map[square.y][square.x]
  end
  for y = 1,constants.sizes.map.h do for x = 1,constants.sizes.map.w do
    PawnClass.pathfinding.map[y][x] = nil
  end end
  self.destination = map.position(self.path[#self.path])
end

function PawnClass:leave()
  self:pathfind(constants.coords.exit)
  map.set_occupant(self.coordinate, nil)
  self.coordinate = Coordinate.dup(constants.coords.exit_off)
  table.insert(self.path, 1, Coordinate.dup(constants.coords.exit_off))
end

function PawnClass:go(coord)
  assert(not map.blocked(coord))
  assert(not map.occupant(coord))

  self:pathfind(coord)

  map.set_occupant(self.coordinate, nil)
  map.set_occupant(coord, self)
  self.coordinate = Coordinate.new(coord.x, coord.y)
end

function PawnClass:update(dt)
  if self.path then
    assert(#self.path > 0 and self.destination)
    local dx, dy = self.destination.x - self.position.x, self.destination.y - self.position.y
    local distance = constants.scale.walk * dt
    while distance > 0 do
      if self.destination.x == self.position.x and self.destination.y == self.position.y then
        table.remove(self.path)
        if #self.path > 0 then
          self.destination = map.position(self.path[#self.path])
        else
          self.path = nil
          self.destination = nil
          distance = 0
          if self.coordinate == constants.coords.exit_off then
            print("Pawn has left the board")
            self.left = true
          end
        end
      end
      distance = self:walk(distance)
    end
  end
end

function PawnClass:walk(distance)
  if distance == 0 then
    return 0
  end

  local dx, dy = self.destination.x - self.position.x, self.destination.y - self.position.y
  assert(dx == 0 or dy == 0)
  if math.abs(dx) + math.abs(dy) > distance then
    if dx ~= 0 then
      -- TODO: Set directions here
      if dx < 0 then
        dx = -distance
      else
        dx = distance
      end
    else
      assert(dy ~= 0)
      if dy < 0 then
        dy = -distance
      else
        dy = distance
      end
    end
    distance = 0
  else
    distance = distance - math.abs(dx) - math.abs(dy)
  end
  self.position.x = self.position.x + dx
  self.position.y = self.position.y + dy
  self:set_screen()
  return distance
end

function PawnClass:clicked(x, y)
  if x >= self.screen.x and x < self.screen.x + constants.sizes.pawn and
     y >= self.screen.y and y < self.screen.y + constants.sizes.pawn then
     return true
   else
     return false
   end
end

