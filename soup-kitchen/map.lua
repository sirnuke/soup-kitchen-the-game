-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

map = {}

function map.create()
  local structure = {
    { 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'T', 'X' },
    { ' ', ' ', ' ', 'X', 'C', 'C', 'C', 'C', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', 'C', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', 'X', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { ' ', ' ', ' ', 'F', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { 'X', 'X', ' ', 'F', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { 'X', 'X', ' ', 'X', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { ' ', ' ', ' ', 'F', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { ' ', ' ', ' ', 'F', ' ', ' ', 'P', 'P', ' ', ' ', 'S', 'S' },
    { ' ', ' ', 'D', 'X', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' }
  }
  map.data = {}
  for y,row in ipairs(structure) do
    local data = {}
    for x,v in ipairs(row) do
      if v == ' ' then
        table.insert(data, map.create_square(Coordinate.new(x, y), false))
      else
        table.insert(data, map.create_square(Coordinate.new(x, y), true))
      end
    end
    table.insert(map.data, data)
  end
  -- Actions
  map.actions = {}
  map.actions.drinks    = ActionClass.new('drinks',    Coordinate.new(2,9), Coordinate.new(3,11))
  map.actions.food1     = ActionClass.new('food1',     Coordinate.new(3,9), Coordinate.new(5,9))
  map.actions.food2     = ActionClass.new('food2',     Coordinate.new(3,8), Coordinate.new(5,8))
  map.actions.food3     = ActionClass.new('food3',     Coordinate.new(3,6), Coordinate.new(5,6))
  map.actions.food4     = ActionClass.new('food4',     Coordinate.new(3,5), Coordinate.new(5,5))
  map.actions.cleaning1 = ActionClass.new('cleaning1', nil,                 Coordinate.new(5,3))
  map.actions.cleaning2 = ActionClass.new('cleaning2', nil,                 Coordinate.new(8,3))
  map.actions.prepare1  = ActionClass.new('prepare1',  nil,                 Coordinate.new(6,4))
  map.actions.prepare2  = ActionClass.new('prepare2',  nil,                 Coordinate.new(6,6))
  map.actions.prepare3  = ActionClass.new('prepare3',  nil,                 Coordinate.new(6,8))
  map.actions.prepare4  = ActionClass.new('prepare4',  nil,                 Coordinate.new(9,5))
  map.actions.prepare5  = ActionClass.new('prepare5',  nil,                 Coordinate.new(9,7))
  map.actions.prepare6  = ActionClass.new('prepare6',  nil,                 Coordinate.new(10,9))
  map.actions.storage1  = ActionClass.new('storage1',  nil,                 Coordinate.new(10,4))
  map.actions.storage2  = ActionClass.new('storage2',  nil,                 Coordinate.new(10,6))
  map.actions.storage3  = ActionClass.new('storage3',  nil,                 Coordinate.new(10,8))
  map.actions.trash     = ActionClass.new('trash',     nil,                 Coordinate.new(11,2))
end

function map.create_square(coord, blocked)
  return { coord=coord, blocked=blocked, occupant=nil, action=nil }
end

function map.square(coord)
  return map.data[coord.y][coord.x]
end

function map.blocked(coord)
  return map.square(coord).blocked
end

function map.position(coord)
  return { x= (coord.x - 1) * constants.sizes.square + constants.sizes.square / 2, 
           y= (coord.y - 1) * constants.sizes.square + constants.sizes.square / 2}
end

function map.coordinate(x, y)
  return Coordinate.new(1 + (x - (x % constants.sizes.square)) / constants.sizes.square,
                        1 + (y - (y % constants.sizes.square)) / constants.sizes.square)
end

function map.valid_coordinate(coord)
  if coord.x >= 1 and coord.x <= constants.sizes.map.w and 
      coord.y >= 1 and coord.y <= constants.sizes.map.h then
    return true
  else
    return false
  end
end

function map.occupant(coord)
  return map.square(coord).occupant
end

function map.set_occupant(coord, occupant)
  map.square(coord).occupant = occupant
end

function map.action(coord)
  return map.square(coord).action
end

function map.set_action(coord, action)
  map.square(coord).action = action
end

function map.get_neighbors(coord)
  local result, poss = { }, { {x=-1,y=0}, {x=1,y=0}, {x=0,y=-1}, {x=0,y=1} }
  local c = Coordinate.new(0, 0)
  for k,v in ipairs(poss) do
    c.x, c.y = coord.x + v.x, coord.y + v.y
    if map.valid_coordinate(c) and not map.blocked(c) then
      table.insert(result, Coordinate.new(c.x, c.y))
    end
  end
  return result
end

