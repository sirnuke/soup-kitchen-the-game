-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Screen = {}

function Screen:setup()
  self.size = {}
  self.size.width = Config.width
  self.size.height = Config.height
  self.fullscreen = Config.fullscreen
  self.fullscreentype = Config.fullscreentype
  self.title = "Soup Kitchen"
  self.letterbox = {height=0, width=0}
  self.letterbox.width = Config.letterboxwidth 
  self.letterbox.height = Config.letterboxheight

  self.scale = {}
  self.scale.width = C.screen.width / (self.size.width - self.letterbox.width)
  self.scale.height = C.screen.height / (self.size.height - self.letterbox.height)

  if self.scale.width ~= self.scale.height then
    Warn("Screen:setup", string.format("Differing scales of (w:%f h:%f)", self.scale.width,
      self.scale.height))
  else
    if self.scale.width ~= 1 then
      Log("Screen:setup", string.format("Scaling width to (%f)", self.scale.width))
    end
    if self.scale.height ~= 1 then
      Log("Screen:setup", string.format("Scaling height to (%f)", self.scale.height))
    end
  end

  self.letterbox.width = self.letterbox.width / 2
  self.letterbox.height = self.letterbox.height / 2

  local settings = {}
  if self.fullscreen then
    settings.fullscreen = true
    settings.fullscreentype = self.fullscreentype
  end

  love.window.setMode(self.size.width, self.size.height, settings)
  love.window.setTitle("Soup Kitchen")
end

function Screen:translate(x, y)
  return Point.new(x / self.scale.width - self.letterbox.width,
                   y / self.scale.height - self.letterbox.height)
end

-- location defaults to (0,0), rotation defaults to 0
function Screen:draw(drawable, location, rotation)
  local loc, rot = location or { x=0, y=0 }, rotation or 0
  love.graphics.draw(drawable, loc.x, loc.y, rot, self.scale.width, self.scale.height,
    self.letterbox.width, self.letterbox.height)
end

-- location defaults to (0,0), rotation defaults to 0
function Screen:print(text, location, rotation)
  local loc, rot = location or { x=0, y=0 }, rotation or 0
  love.graphics.print(text, loc.x, loc.y, rot, self.scale.width, self.scale.height,
    self.letterbox.width, self.letterbox.height)
end


