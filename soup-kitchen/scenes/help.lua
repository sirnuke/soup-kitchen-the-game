-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

help = { }

function help.enter()
  help.background = love.graphics.newImage("images/help/background.png")
  help.squelch = constants.squelch
end

function help.exit()
  help.background = nil
end

function help.draw()
  love.graphics.draw(help.background)
end

function help.update(dt)
  if help.squelch > 0 then
    help.squelch = help.squelch - dt
  end
end

function help.keypressed(key)
  if help.squelch <= 0 then
  end
end

function help.keyreleased(key)
end

function help.mousepressed(x, y, button)
  if help.squelch <= 0 and button == 'l' then
    core.switch("ingame")
  end
end

function help.mousereleased(x, y, button)
end
