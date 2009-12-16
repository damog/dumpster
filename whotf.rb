#!/usr/bin/env ruby

class Array

  def randomize
    duplicated_original, new_array = self.dup, self.class.new
    new_array << 
duplicated_original.slice!(rand(duplicated_original.size)) until 
new_array.size.eql?(self.size)
    new_array
  end

  def randomize!
    self.replace(randomize)
  end

end

tlds = %w/com org net/

arg = (1000..9999).to_a

thr = []

for i in arg.randomize
  for tld in tlds
    domain = "#{i}.#{tld}"
    puts "checking for #{domain}"
    Thread.new {
      begin
        puts domain if `whois #{domain}` =~ /No match for/
      rescue
        next
      end
    }
  end
end
