-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Font = {}
Font.loaded = {}

function Font.load(pointsize)
  assert(type(pointsize) == 'number' and pointsize > 0)
  if Font.loaded[pointsize] then
    return Font.loaded[pointsize]
  else
    local font = love.graphics.newFont(C.font.filename, pointsize)
    Font.loaded[pointsize] = font
    return font
  end
end

