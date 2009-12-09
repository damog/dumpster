#!/opt/local/bin/ruby

require "rubygems"
require "twitter"

httpauth = Twitter::HTTPAuth.new(
	ARGV[0],
	ARGV[1]
)

base = Twitter::Base.new(httpauth)

i = 0
(base.follower_ids - base.friend_ids).each do |id|
  begin
    base.friendship_create id
    i += 1
  rescue Twitter::General => e
    puts "#{e.class}: #{e.message}"
  rescue Twitter::Unavailable
    sleep 2
    retry
  end
end
puts "#{i} new friendships."

i = 0
(base.friend_ids - base.follower_ids).each do |id|
  i += 1
  base.friendship_destroy id
end
puts "#{i} destroyed friendships."

puts "#{base.friend_ids.size} friends now."
puts "#{base.follower_ids.size} followers now."
