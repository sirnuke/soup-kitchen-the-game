-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Font = {}
Font.loaded = {}

function Font.load(size, style)
  assert(type(size) == 'number' and size > 0)
  if not style then style = 'normal' end
  assert(C.font.files[style], string.format("Unknown style %s", style))
  if not Font.loaded[style] then
    Font.loaded[style] = {}
  end
  if Font.loaded[style][size] then
    return Font.loaded[style][size]
  else
    local font = love.graphics.newFont(C.font.files[style], size)
    Font.loaded[style][size] = font
    return font
  end
end

