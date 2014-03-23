
function core.config()
  love.window.setMode(1024, 768, {})
  love.window.setTitle("Soup Kitchen")

  core.constants = {}
  core.constants.eat = 0.25
  core.constants.walk = 100
  core.constants.font_size = 22
  core.constants.time_scale = 1
  core.constants.small_font_size = 14
  core.constants.day_start = 480 -- 8:00am
  core.constants.lunch = 660 -- 11:00am
  core.constants.prepare = 780 -- 1:00pm
  core.constants.dinner = 960 -- 4:00pm
  core.constants.cleanup = 1080 -- 6:00pm
  core.constants.day_end = 1200 -- 8:00pm
  core.constants.money_start = 1000
  core.constants.employee_wage = 50
  core.constants.start_location = {x=5, y=11}
  core.sizes = {}
  core.sizes.square = {width=64, height=64}
  core.sizes.pawn = {width=32, height=32}
  core.sizes.map = {width=12, height=12}
end
