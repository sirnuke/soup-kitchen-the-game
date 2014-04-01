-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

mainmenu = { }

function mainmenu.enter()
  mainmenu.background = love.graphics.newImage("images/mainmenu/background.png")
  mainmenu.squelch = constants.squelch
end

function mainmenu.exit()
  mainmenu.background = nil
end

function mainmenu.draw()
  love.graphics.draw(mainmenu.background)
end

function mainmenu.update(dt)
  if mainmenu.squelch > 0 then
    mainmenu.squelch = mainmenu.squelch - dt
  end
end

function mainmenu.keypressed(key)
  if mainmenu.squelch <= 0 then
  end
end

function mainmenu.keyreleased(key)
end

function mainmenu.mousepressed(x, y, button)
  if mainmenu.squelch <= 0 and button == 'l' then
    core.switch("help")
  end
end

function mainmenu.mousereleased(x, y, button)
end

