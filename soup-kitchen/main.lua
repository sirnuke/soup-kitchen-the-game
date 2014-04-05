-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

require "utilities/configuration"
require "utilities/constants"
require "utilities/coordinate"
require "utilities/font"
require "utilities/logging"
require "utilities/point"
require "utilities/screen"

require "gui/interactable"
require "gui/meal-selection/option"
require "gui/meal-selection/overlay"
require "gui/meal-selection/slot"

require "scenes/help"
require "scenes/ingame"
require "scenes/mainmenu"

require "equipment/equipment"
require "equipment/serving"

require "state/customer"
require "state/homeless"
require "state/map"
require "state/pawn"
require "state/state"
require "state/stock"
require "state/task"

local tag = "Core"

Core = {}

function inherits(class, instance)
  assert(type(class) == 'table' and type(instance) == 'table')
  for k,v in pairs(class) do
    if not instance[k] then
      instance[k] = v
    end
  end
end

local function version_check()
  if not love.math then
    Error(tag, "love runtime appears to be out of date (requires 0.9.0+)")
  end
  if love.getVersion then
    local major, minor, revision = love.getVersion()
    Log(tag, string.format("Love runtime is (%i.%i.%i)", major, minor, revision))
  else
    Log(tag, "Love runtime appears to be (0.9.0)")
  end
end

function love.load()
  version_check()
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
  Core.scene:update(dt)
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

function Core:switch(scene)
  self.next = scene
end

