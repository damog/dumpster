def fact(n)
  if n == 0
    1
  else
    n * fact(n-1)
  end
end

g = ARGV[1].to_i
l = ARGV[0].to_i

puts "#{l} in #{g}: #{fact( g + l - 1 )/(fact(l) * fact(g - 1))}"

