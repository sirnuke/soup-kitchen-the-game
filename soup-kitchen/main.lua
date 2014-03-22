-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

require "config"
require "mainmenu"

function love.load()
  config()
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

function love.mousepressed(x, y, button)
  scene.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  scene.mousereleased(x, y, button)
end

