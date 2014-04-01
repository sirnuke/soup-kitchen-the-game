-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

Config = {}

function Config:load()
  self.width =  C.screen.width
  self.height = C.screen.height
  self.fullscreen = false
  self.fullscreentype = 'desktop'
  self.letterboxwidth  = 0
  self.letterboxheight = 0
  -- TODO: Attempt to load from the user's configuration file
end
