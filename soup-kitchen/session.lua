-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

session = {}

function session.start()
  session.day = 1
  session.time = 0.0
  session.cash = 1000
  session.stock = {}
  for i = 1,3 do table.insert(session.stock, StockClass.random('core')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('side')) end
  for i = 1,3 do table.insert(session.stock, StockClass.random('drink')) end
  for i = 1,5 do table.insert(session.stock, StockClass.random('desert')) end
  for i = 1,2 do table.insert(session.stock, StockClass.random('salad')) end

  session.player = PawnClass.new('player', 5, 11)
end

