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
  else
    scene.keypressed(key)
  end
end

function love.keyreleased(key)
  scene.keyreleased(key)
end

function love.update(dt)
  scene.update(dt)
end

