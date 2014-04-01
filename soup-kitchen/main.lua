-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

core = {}

require "config"
require "coordinate"
require "gui-element"

require "help"
require "ingame"
require "mainmenu"

require "equipment/equipment"
require "equipment/serving"

require "customer"
require "homeless"
require "map"
require "meal-selection"
require "meal-selection-slot"
require "meal-selection-option"
require "pawn"
require "session"
require "stock"
require "task"

function inherits(class, instance)
  assert(type(class) == 'table' and type(instance) == 'table')
  for k,v in pairs(class) do
    if not instance[k] then
      instance[k] = v
    end
  end
end

function love.load()
  core.config()
  core.scenes = { mainmenu=mainmenu, help=help, ingame=ingame }
  core.next = nil
  core.scene = mainmenu
  core.scene.enter()
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 255)
  core.scene.draw()
end

function love.keypressed(key)
  if key == "q" then
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

