-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

mainmenu = { }

function mainmenu.enter()
  if mainmenu.background == nil then
    mainmenu.background = love.graphics.newImage("images/mainmenu/background.png")
  end
end

function mainmenu.exit()
  mainmenu.background = nil
end

function mainmenu.draw()
  love.graphics.draw(mainmenu.background)
end

function mainmenu.update(dt)
end

function mainmenu.keypressed(key)
end

function mainmenu.keyreleased(key)
end

