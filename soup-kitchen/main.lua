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

Core = {}

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
  Core.scenes = { MainMenu=MainMenu, Help=Help, InGame=InGame }
  Core.next = nil
  Core.scene = MainMenu
  Core.scene:enter()
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 255)
  Core.scene:draw()
end

function love.keypressed(key)
  if key == "q" then
    love.event.quit()
  else
    Core.scene:keypressed(key)
  end
end

function love.keyreleased(key)
  Core.scene:keyreleased(key)
end

function love.update(dt)
  Core.scene.update(dt)
  if Core.next then
    Core.scene:exit()
    Core.scene = Core.scenes[Core.next]
    Core.scene:enter()
    Core.next = nil
  end
end

function love.mousepressed(x, y, button)
  Core.scene:mousepressed(Screen:translate(x, y), button)
end

function love.mousereleased(x, y, button)
  Core.scene:mousereleased(Screen:translate(x, y), button)
end

function Core.switch(scene)
  Core.next = scene
end

