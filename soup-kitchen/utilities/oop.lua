-- Soup Kitchen
-- Bryan DeGrendel (c) 2014

function inherits(class, instance)
  assert(type(class) == 'table' and type(instance) == 'table')
  for k,v in pairs(class) do
    if not instance[k] then
      instance[k] = v
    end
  end
end
