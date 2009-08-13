#!/usr/bin/ruby

require 'timeout'

('aaa'..'zzzz').each { |sub|
	next unless sub =~ /[aeiou]/
	domain = sub + '.com'
#	domain = sub + 'box.com'

	print "Trying... " + domain

	begin
		Timeout::timeout(5) {
			if `whois #{domain} 2>&1` =~ /no match/i
				puts " AVAILABLE!"
			else
				puts " meh."
			end
		}
	rescue Timeout::Error
		puts " meh."
	end

}
