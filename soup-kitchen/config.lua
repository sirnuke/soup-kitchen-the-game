
function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")

  core.constants = {}
  core.constants.eat = 0.25
  core.constants.walk = 100
  core.constants.font_size = 22
  core.constants.time_scale = 0.5
  core.constants.small_font_size = 14
  core.constants.day_start = 450 -- 7:30am
  core.constants.day_end = 1170 -- 7:30pm
  core.constants.money_start = 1000
  core.constants.employee_wage = 50
  core.sizes = {}
  core.sizes.square = {width=64, height=64}
  core.sizes.pawn = {width=32, height=32}
  core.sizes.map = {width=12, height=12}
end
