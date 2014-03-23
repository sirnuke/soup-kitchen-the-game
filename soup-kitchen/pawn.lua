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
    PawnClass.pathfinding.neighbors = { }

    for y = 1,core.sizes.map.height do
      local row = { }
      for x = 1,core.sizes.map.width do
        table.insert(row, nil)
      end
      table.insert(PawnClass.pathfinding.map, row)
    end

    for x = -1,1 do for y = -1,1 do
      if x ~= 0 or y ~= 0 then
        table.insert(PawnClass.pathfinding.neighbors, { x=x, y=y } )
      end 
    end end
  end

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.type = type
  instance.position = map.position(x, y)
  instance.coordinate = { x=x, y=y }
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
  love.graphics.draw(PawnClass.images[self.type], self.position.x, self.position.y)
end

function PawnClass:go(x, y)
  assert(not map.blocked(x, y))
  assert(not map.occupant(x, y))

  PawnClass.pathfinding.map[self.coordinate.y][self.coordinate.x] = true

  print("Performing breadth first search...")
  local queue = { self.coordinate }
  local nx, ny

  while #queue > 0 and (queue[1].x ~= x or queue[1].y ~= y) do
    print("Getting neighbors of ", queue[1].x, queue[1].y)

    for k,v in ipairs(PawnClass.pathfinding.neighbors) do
      nx, ny = queue[1].x + v.x, queue[1].y + v.y
      if map.validcoordinate(nx, ny) and not PawnClass.pathfinding.map[ny][nx] then
        PawnClass.pathfinding.map[ny][nx] = { x=queue[1].x, y=queue[1].y }
        table.insert(queue, { x=nx, y=ny })
      end
    end
    table.remove(queue, 1)
  end
  assert(queue[1].x == x and queue[1].y == y, "Couldn't find a path!")
  self.destination = { {x=x, y=y} }
  local square = PawnClass.pathfinding.map[y][x]
  print("Path ends up at ", x, y, type(square))
  while type(square) ~= "boolean" do
    assert(type(square) == "table")
    table.insert(self.destination, { x=square.x, y=square.y })
    print("Looking up parent of ", square.x, square.y)
    square = PawnClass.pathfinding.map[square.y][square.x]
  end
  for y = 1,core.sizes.map.height do for x = 1,core.sizes.map.width do
    PawnClass.pathfinding.map[y][x] = nil
  end end

  map.setoccupant(self.coordinate.x, self.coordinate.y, nil)
  map.setoccupant(x, y, self)
  self.coordinate.x = x
  self.coordinate.y = y
end

function PawnClass:update(dt)
  if self.destination then
    --self.position = self.destination
    self.destination = nil
  end
end

function PawnClass:clicked(x, y)
  if x >= self.position.x and x < self.position.x + core.sizes.pawn.width and
     y >= self.position.y and y < self.position.y + core.sizes.pawn.height then
     return true
   else
     return false
   end
end

