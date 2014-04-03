-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function Error(tag, msg)
  io.write(string.format("[E][%s]: %s\n", tag, msg))
end

function Warn(tag, msg)
  io.write(string.format("[W][%s]: %s\n", tag, msg))
end

function Log(tag, msg)
  io.write(string.format("[L][%s]: %s\n", tag, msg))
end

