
function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")

  core.eat = 0.25
  core.sizes = {}
  core.sizes.square = {width=64, height=64}
  core.sizes.pawn = {width=32, height=32}
  core.sizes.map = {width=12, height=12}
end
