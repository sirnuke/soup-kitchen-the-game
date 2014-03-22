-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

core = {}

require "config"
require "mainmenu"

function love.load()
  core.config()
  core.scenes = {}
  core.scenes.mainmenu = mainmenu
  core.next = nil
  core.scene = mainmenu
  core.scene.enter()
end

function love.draw()
  core.scene.draw()
end

function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  else
    core.scene.keypressed(key)
  end
end

function love.keyreleased(key)
  core.scene.keyreleased(key)
end

function love.update(dt)
  core.scene.update(dt)
  if core.next then
    core.scene.exit()
    core.scene = core.scenes[core.next]
    core.scene.enter()
    core.next = nil
  end
end

function love.mousepressed(x, y, button)
  core.scene.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  core.scene.mousereleased(x, y, button)
end

function core.switch(scene)
  core.next = scene
end

