-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

require "utilities/configuration"
require "utilities/constants"
require "utilities/coordinate"
require "utilities/logging"
require "utilities/point"
require "utilities/screen"

require "gui/interactable"

require "scenes/help"
require "scenes/ingame"
require "scenes/mainmenu"

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

core = {}

function inherits(class, instance)
  assert(type(class) == 'table' and type(instance) == 'table')
  for k,v in pairs(class) do
    if not instance[k] then
      instance[k] = v
    end
  end
end

function love.load()
  C:setup()
  Config:load()
  Screen:setup()
  core.scenes = { MainMenu=MainMenu, Help=Help, InGame=InGame }
  core.next = nil
  core.scene = MainMenu
  core.scene:enter()
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 255)
  core.scene:draw()
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  else
    core.scene:keypressed(key)
  end
end

function love.keyreleased(key)
  core.scene:keyreleased(key)
end

function love.update(dt)
  core.scene.update(dt)
  if core.next then
    core.scene:exit()
    core.scene = core.scenes[core.next]
    core.scene:enter()
    core.next = nil
  end
end

function love.mousepressed(x, y, button)
  core.scene:mousepressed(Screen:translate(x, y), button)
end

function love.mousereleased(x, y, button)
  core.scene:mousereleased(Screen:translate(x, y), button)
end

function core.switch(scene)
  core.next = scene
end

