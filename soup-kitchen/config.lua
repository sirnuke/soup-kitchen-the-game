
function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")

  core.eat = 0.25
  core.square = {width=64, height=64}
  core.pawn = {width=32, height=32}
end
