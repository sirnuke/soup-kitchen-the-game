-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

require "mainmenu"

function love.load()
  scene = mainmenu
  mainmenu.enter()
end

function love.draw()
  scene.draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end

function love.update(dt)
  scene.update(dt)
end

