-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Map = {}

function Map:create()
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
  self.data = {}
  for y,row in ipairs(structure) do
    local data = {}
    for x,v in ipairs(row) do
      if v == ' ' then
        table.insert(data, {coord=Coordinate.new(x, y), blocked=false, occupant=nil, equipment=nil})
      else
        table.insert(data, {coord=Coordinate.new(x, y), blocked=true,  occupant=nil, equipment=nil})
      end
    end
    table.insert(self.data, data)
  end

  self.equipment = {}

  self.equipment.serving = {}
  self.equipment.serving[1] = ServingClass.new(1,
    Coordinate.new(3,10), Coordinate.new(2,9), Coordinate.new(3,11))
  self.equipment.serving[2] = ServingClass.new(2,
    Coordinate.new(4,9), Coordinate.new(3,9), Coordinate.new(5,9))
  self.equipment.serving[3] = ServingClass.new(3,
    Coordinate.new(4,8), Coordinate.new(3,8), Coordinate.new(5,8))
  self.equipment.serving[4] = ServingClass.new(4,
    Coordinate.new(4,6), Coordinate.new(3,6), Coordinate.new(5,6))
  self.equipment.serving[5] = ServingClass.new(5,
    Coordinate.new(4,5), Coordinate.new(3,5), Coordinate.new(5,5))

  self.equipment.cleaning = {}
  self.equipment.cleaning[1] = ActionClass.new('cleaning1', nil, Coordinate.new(5,3))
  self.equipment.cleaning[2] = ActionClass.new('cleaning2', nil, Coordinate.new(7,3))
  self.equipment.cleaning[3] = ActionClass.new('cleaning3', nil, Coordinate.new(8,3))

  self.equipment.prepare = {}
  self.equipment.prepare[1] = ActionClass.new('prepare1', nil, Coordinate.new(6,4))
  self.equipment.prepare[2] = ActionClass.new('prepare2', nil, Coordinate.new(6,6))
  self.equipment.prepare[3] = ActionClass.new('prepare3', nil, Coordinate.new(6,8))
  self.equipment.prepare[4] = ActionClass.new('prepare4', nil, Coordinate.new(9,5))
  self.equipment.prepare[5] = ActionClass.new('prepare5', nil, Coordinate.new(9,7))
  self.equipment.prepare[6] = ActionClass.new('prepare6', nil, Coordinate.new(10,9))

  self.equipment.storage = {}
  self.equipment.storage[1] = ActionClass.new('storage1', nil, Coordinate.new(10,4))
  self.equipment.storage[2] = ActionClass.new('storage2', nil, Coordinate.new(10,6))
  self.equipment.storage[3] = ActionClass.new('storage3', nil, Coordinate.new(10,8))

  self.equipment.trash = {}
  self.equipment.trash[1] = ActionClass.new('trash', nil, Coordinate.new(11,2))
end

function Map:square(coord)
  return self.data[coord.y][coord.x]
end

function Map:blocked(coord)
  return self:square(coord).blocked
end

function Map:occupant(coord)
  return self:square(coord).occupant
end

function Map:set_occupant(coord, occupant)
  self:square(coord).occupant = occupant
end

function Map.equipment(coord)
  return self:square(coord).equipment
end

function Map:get_neighbors(coord)
  local result, poss = { }, { {x=-1,y=0}, {x=1,y=0}, {x=0,y=-1}, {x=0,y=1} }
  local c = Coordinate.new(0, 0)
  for k,v in ipairs(poss) do
    c.x, c.y = coord.x + v.x, coord.y + v.y
    if self:valid_coordinate(c) and not self:blocked(c) then
      table.insert(result, Coordinate.new(c.x, c.y))
    end
  end
  return result
end

