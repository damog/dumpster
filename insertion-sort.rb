require "pp"

list = ARGV

list.each_with_index do |val, i|
  curr_val = val.to_i
  position = i

  while position > 0 and list[ position - 1 ] > curr_val
    list[ position ] = list[ position - 1 ]
    position = position - 1
  end

  list[position] = curr_val
end

pp list
