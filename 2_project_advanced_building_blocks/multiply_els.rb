load 'my_enumerable_methods.rb'

def multiply_els(arr)
  arr.my_inject {|acc, el| acc * el}
end
