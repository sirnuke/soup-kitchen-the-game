-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

PawnClass = {}
PawnClass.__index = PawnClass

function PawnClass.new(map, coord)

  if not PawnClass.pathfinding then
    PawnClass.pathfinding = { }
    PawnClass.pathfinding.map = { }

    for y = 1,C.sizes.map.height do
      local row = { }
      for x = 1,C.sizes.map.width do
        table.insert(row, nil)
      end
      table.insert(PawnClass.pathfinding.map, row)
    end
  end

  local instance = {}
  setmetatable(instance, PawnClass)
  instance.exited = false
  instance.task = false
  instance.map = map
  if coord then
    assert(not map:blocked(coord) and not map:occupant(coord))
    instance.position = coord:point()
    instance.coordinate = coord:duplicate()
    instance.path = nil
    instance.destination = nil
    map:set_occupant(instance.coordinate, instance)
  else
    instance.position = nil
    instance.coordinate = nil
    instance.path = nil
    instance.destination = nil
  end
  instance.gui = InteractableClass.new(instance.coordinate, C.sizes.pawn, C.sizes.pawn)
  return instance
end

function PawnClass:enter(coordinate)
  assert(coordinate)
  assert(not map:occupied(ccordinate))
  self.position = coordinate:point()
  self.position.x = self.position.x - C.sizes.square
  self.coordinate = coordinate:duplicate()
  self.path = { coordinate:duplicate() }
  self.destination = coordinate:point()
  map:set_occupant(self.coordinate, self)
end

function PawnClass:spawned()
  if not self.position then
    return false
  else
    return true
  end
end

function PawnClass:draw()
  -- TODO: This function will almost certainly be overridden in the future
  assert(self.image, "Child didn't load an image!")
  Screen:draw(self.image, self.screen)
end

function PawnClass:set_screen()
  self.screen = self.coordinate:screen()
  self.gui:set_point(self.screen)
end

function PawnClass:jump(coordinate)
  self.path = nil
  self.destination = nil
  self.coordinate = coordinate:duplicate()
  self.position = coordinate:point()
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
  local current = self.position:coordinate()

  PawnClass.pathfinding.map[current.y][current.x] = true

  local queue = { current }

  print(string.format("Pathfinding from (%i,%i) to (%i,%i)", self.coordinate.x,
    self.coordinate.y, coord.x, coord.y))

  while #queue > 0 and queue[1] ~= coord do
    --print("Getting neighbors of ", queue[1].x, queue[1].y)
    for k,v in ipairs(self.map:get_neighbors(queue[1])) do
      --print("Checking", v.x, v.y)
      if not PawnClass.pathfinding.map[v.y][v.x] then
        PawnClass.pathfinding.map[v.y][v.x] = queue[1]:duplicate()
        table.insert(queue, v:duplicate())
      end
    end
    table.remove(queue, 1)
  end
  assert(#queue > 0, "Couldn't find a path!")
  assert(queue[1] == coord, "Top of queue should be the end")
  self.path = { coord:duplicate() }
  local square = PawnClass.pathfinding.map[coord.y][coord.x]
  --print("Path ends up at ", x, y, type(square))
  while type(square) ~= "boolean" do
    assert(type(square) == "table")
    table.insert(self.path, square:duplicate())
    --print("Looking up parent of ", square.x, square.y)
    square = PawnClass.pathfinding.map[square.y][square.x]
  end
  for y = 1,C.sizes.map.height do for x = 1,C.sizes.map.width do
    PawnClass.pathfinding.map[y][x] = nil
  end end
  self.destination = self.path[#self.path]:point()
end

function PawnClass:leave(coordinate)
  assert(coordinate and coordinate.x == 1)
  self:pathfind(coordinate)
  self.map:set_occupant(self.coordinate, nil)
  self.coordinate = coordinate:duplicate()
  self.coordinate.x = 0
  table.insert(self.path, 1, self.coordinate:duplicate())
end

function PawnClass:go(coord)
  assert(not self.map:blocked(coord))
  assert(not self.map:occupant(coord))

  self:pathfind(coord)

  self.map:set_occupant(self.coordinate, nil)
  self.map:set_occupant(coord, self)
  self.coordinate = coord:duplicate()
end

function PawnClass:move(dt)
  if self.path then
    assert(#self.path > 0 and self.destination)
    local distance = C.scale.walk * dt
    while distance > 0 do
      if self.destination == self.position then
        table.remove(self.path)
        if #self.path > 0 then
          self.destination = self.path[#self.path]:point()
        else
          self.path = nil
          self.destination = nil
          distance = 0
          if self.coordinate.x == 0 then
            print("Pawn has left the board")
            self.exited = true
          end
        end
      end
      distance = self:walk(distance)
    end
  end
end

function PawnClass:walk(distance)
  if distance == 0 then return 0 end

  local delta = self.destination - self.position
  assert(delta.x == 0 or delta.y == 0)
  if math.abs(delta.x) + math.abs(delta.y) > distance then
    if delta.x ~= 0 then
      -- TODO: Set directions here
      if delta.x < 0 then
        delta.x = -distance
      else
        delta.x = distance
      end
    else
      assert(delta.y ~= 0)
      if delta.y < 0 then
        delta.y = -distance
      else
        delta.y = distance
      end
    end
    distance = 0
  else
    distance = distance - math.abs(delta.x) - math.abs(delta.y)
  end
  self.position.x = self.position.x + delta.x
  self.position.y = self.position.y + delta.y
  self:set_screen()
  return distance
end

