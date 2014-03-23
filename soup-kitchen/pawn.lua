-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass
PawnClass.types = { player='player', employee='employee', volunteer='volunteer',
  customer='customer' }
PawnClass.images = { }

function PawnClass.new(type, x, y)
  assert(not map.blocked(x, y))
  assert(not map.occupant(x, y))
  assert(PawnClass.types[type])

  if not PawnClass.pathfinding then
    PawnClass.pathfinding = { }
    PawnClass.pathfinding.map = { }

    for y = 1,core.sizes.map.height do
      local row = { }
      for x = 1,core.sizes.map.width do
        table.insert(row, nil)
      end
      table.insert(PawnClass.pathfinding.map, row)
    end
  end

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.position = map.position(x, y)
  instance.screen = { }
  instance.screen.x = instance.position.x - (core.sizes.square.width - core.sizes.pawn.width) / 2
  instance.screen.y = instance.position.y - (core.sizes.square.height - core.sizes.pawn.height) / 2
  instance.coordinate = { x=x, y=y }
  instance.path = nil
  instance.destination = nil
  instance.skills = {}

  map.setoccupant(x, y, instance)

  if type == 'player' then
    if not PawnClass.images.player then
      PawnClass.images.player = love.graphics.newImage("images/pawns/player.png")
    end
  elseif type == 'employee' then
  elseif type == 'volunteer' then
  elseif type == 'customer' then
  else
    assert(false, string.format("Unhandled pawn type %s", type))
  end

  return instance
end

function PawnClass:draw()
  love.graphics.draw(PawnClass.images[self.type], self.screen.x, self.screen.y)
end

function PawnClass:go(x, y)
  assert(not map.blocked(x, y))
  assert(not map.occupant(x, y))

  PawnClass.pathfinding.map[self.coordinate.y][self.coordinate.x] = true

  print("Performing breadth first search...")
  local queue = { self.coordinate }

  while #queue > 0 and (queue[1].x ~= x or queue[1].y ~= y) do
    print("Getting neighbors of ", queue[1].x, queue[1].y)
    for k,v in ipairs(map.getneighbors(queue[1].x, queue[1].y)) do
      if not PawnClass.pathfinding.map[v.y][v.x] then
        PawnClass.pathfinding.map[v.y][v.x] = { x=queue[1].x, y=queue[1].y }
        table.insert(queue, { x=v.x, y=v.y })
      end
    end
    table.remove(queue, 1)
  end
  assert(#queue > 0, "Couldn't find a path!")
  assert(queue[1].x == x and queue[1].y == y, "Top of queue should be the end")
  self.path = { {x=x, y=y} }
  local square = PawnClass.pathfinding.map[y][x]
  print("Path ends up at ", x, y, type(square))
  while type(square) ~= "boolean" do
    assert(type(square) == "table")
    table.insert(self.path, { x=square.x, y=square.y })
    print("Looking up parent of ", square.x, square.y)
    square = PawnClass.pathfinding.map[square.y][square.x]
  end
  for y = 1,core.sizes.map.height do for x = 1,core.sizes.map.width do
    PawnClass.pathfinding.map[y][x] = nil
  end end
  print("Removing", self.path[#self.path].x, self.path[#self.path].y)
  table.remove(self.path)
  print("Next step is", self.path[#self.path].x, self.path[#self.path].y)

  self.destination = map.position(self.path[#self.path].x, self.path[#self.path].y)

  map.setoccupant(self.coordinate.x, self.coordinate.y, nil)
  map.setoccupant(x, y, self)
  self.coordinate.x = x
  self.coordinate.y = y
end

function PawnClass:update(dt)
  if self.path then
    assert(#self.path > 0 and self.destination)
    local dx, dy = self.destination.x - self.position.x, self.destination.y - self.position.y
    print("Current is", self.position.x, self.position.y)
    print("Destination is", self.destination.x, self.destination.y)
    assert(dx == 0 or dy == 0)
    dx, dy = dx * core.constants.walk, dy * core.constants.walk
    print("Would move", dx, dy)
  end
end

function PawnClass:clicked(x, y)
  if x >= self.screen.x and x < self.screen.x + core.sizes.pawn.width and
     y >= self.screen.y and y < self.screen.y + core.sizes.pawn.height then
     return true
   else
     return false
   end
end

