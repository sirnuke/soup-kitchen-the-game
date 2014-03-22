-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function love.load()

end

function love.draw()
end

function love.update(dt)
end

function love.run()
  if love.math then
    love.math.setRandomSeed(os.time())
  end

  if love.event then
    love.event.pump()
  end

  if love.timer then love.timer.step() end
  local dt = 0

  while true do -- Process events.  if love.event then
    love.event.pump()
    for e,a,b,c,d in love.event.poll() do
      if e == "quit" then
        if not love.quit or not love.quit() then
          return
        end
      end
      love.handlers[e](a,b,c,d)
    end

    -- Update dt, as we'll be passing it to update
    love.timer.step()
    dt = love.timer.getDelta()

    -- Call update and draw
    love.update(dt)

    if love.window.isCreated() then
      love.graphics.clear()
      love.graphics.origin()
      love.draw()
      love.graphics.present()
    end

    love.timer.sleep(0.001)
  end

end
