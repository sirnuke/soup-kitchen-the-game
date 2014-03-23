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
    { ' ', 'D', 'D', 'X', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'X' },
    { 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X', 'X' }
  }
  map.data = {}
  for y,row in ipairs(structure) do
    local data = {}
    for x,v in ipairs(row) do
      print(x,y,v)
      if v == ' ' then
        table.insert(data, map.create_square(x, y, false))
      else
        table.insert(data, map.create_square(x, y, true))
      end
    end
    table.insert(map.data, data)
  end
end

function map.create_square(x, y, blocked)
  return { x=x, y=y, blocked=blocked, occupant=nil }
end

function map.blocked(x, y)
  return map.data[y][x].blocked
end

function map.position(x, y)
  return { x= (x - 1) * core.sizes.square.width  + core.sizes.square.width / 2, 
           y= (y - 1) * core.sizes.square.height + core.sizes.square.height / 2}
end

function map.coordinate(x, y)
  return { x= 1 + (x - (x % core.sizes.square.width))  / core.sizes.square.width,
           y= 1 + (y - (y % core.sizes.square.height)) / core.sizes.square.height }
end

function map.validcoordinate(x, y)
  if x >= 0 and x <= core.sizes.map.width and y >= 0 and y <= core.sizes.map.height then
    return true
  else
    return false
  end
end

function map.occupant(x, y)
  return map.data[y][x].occupant
end

function map.setoccupant(x, y, occupant)
  map.data[y][x].occupant = occupant
end

