-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

MapClass = {}

function MapClass:create()
  local structure = {
    { 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'T', 'X' },
    { ' ', ' ', ' ', 'X', 'C', 'C', 'C', 'C', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', 'C', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', 'X', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
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
  self.equipment.serving.drinks 
    = ServingClass.new('drinks', Coordinate.new(3,10), Coordinate.new(3,11))
  self.equipment.serving.food1
    = ServingClass.new('food1', Coordinate.new(4,9), Coordinate.new(5,9))
  self.equipment.serving.food2
    = ServingClass.new('food2', Coordinate.new(4,8), Coordinate.new(5,8))
  self.equipment.serving.food3
    = ServingClass.new('food3', Coordinate.new(4,6), Coordinate.new(5,6))
  self.equipment.serving.food4
    = ServingClass.new('food4', Coordinate.new(4,5), Coordinate.new(5,5))

  self.equipment.receiving = {}
  self.equipment.receiving[1] = EquipmentClass.new(Coordinate.new(3,10), Coordinate.new(2,9))
  self.equipment.receiving[2] = EquipmentClass.new(Coordinate.new(4,9), Coordinate.new(3,9))
  self.equipment.receiving[3] = EquipmentClass.new(Coordinate.new(4,8), Coordinate.new(3,8))
  self.equipment.receiving[4] = EquipmentClass.new(Coordinate.new(4,6), Coordinate.new(3,6))
  self.equipment.receiving[5] = EquipmentClass.new(Coordinate.new(4,5), Coordinate.new(3,5))

  self.equipment.cleaning = {}
  self.equipment.cleaning[1] = EquipmentClass.new(Coordinate.new(4,3), Coordinate.new(5,3))
  self.equipment.cleaning[2] = EquipmentClass.new(Coordinate.new(6,2), Coordinate.new(6,3))
  self.equipment.cleaning[3] = EquipmentClass.new(Coordinate.new(8,2), Coordinate.new(8,3))

  self.equipment.prepare = {}
  self.equipment.prepare[1] = EquipmentClass.new(Coordinate.new(8,4), Coordinate.new(9,4))
  self.equipment.prepare[2] = EquipmentClass.new(Coordinate.new(8,5), Coordinate.new(9,5))
  self.equipment.prepare[3] = EquipmentClass.new(Coordinate.new(8,6), Coordinate.new(9,6))
  self.equipment.prepare[4] = EquipmentClass.new(Coordinate.new(8,7), Coordinate.new(9,7))
  self.equipment.prepare[5] = EquipmentClass.new(Coordinate.new(8,8), Coordinate.new(9,8))

  self.equipment.storage = {}
  self.equipment.storage[1] = EquipmentClass.new(Coordinate.new(11,4), Coordinate.new(10,4))
  self.equipment.storage[2] = EquipmentClass.new(Coordinate.new(11,5), Coordinate.new(10,5))
  self.equipment.storage[3] = EquipmentClass.new(Coordinate.new(11,6), Coordinate.new(10,6))
  self.equipment.storage[3] = EquipmentClass.new(Coordinate.new(11,7), Coordinate.new(10,7))
  self.equipment.storage[3] = EquipmentClass.new(Coordinate.new(11,8), Coordinate.new(10,8))

  self.equipment.trash = {}
  self.equipment.trash[1] = EquipmentClass.new(Coordinate.new(11,1), Coordinate.new(11,2))
end

function MapClass:square(coord)
  return self.data[coord.y][coord.x]
end

function MapClass:blocked(coord)
  return self:square(coord).blocked
end

function MapClass:occupant(coord)
  return self:square(coord).occupant
end

function MapClass:set_occupant(coord, occupant)
  self:square(coord).occupant = occupant
end

function MapClass.equipment(coord)
  return self:square(coord).equipment
end

function MapClass:get_neighbors(coord)
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

