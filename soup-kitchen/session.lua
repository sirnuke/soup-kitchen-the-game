-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}

function session.start()
  session.day = 1
  session.time = 0.0
  session.stock = {}
  table.insert(session.stock, StockClass.new(0, 0))
end

