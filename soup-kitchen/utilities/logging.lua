-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function Error(func, msg)
  io.write(string.format("[E][%s]: %s\n", func, msg))
end

function Warn(func, msg)
  io.write(string.format("[W][%s]: %s\n", func, msg))
end

function Log(func, msg)
  io.write(string.format("[L][%s]: %s\n", func, msg))
end

