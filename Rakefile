require 'twitter'
require 'dotenv'

##
# Use dotenv to load configuration
if File.exist?('.env')
  Dotenv.load
else
  throw 'You must first copy your credentials to the .env file.'
end

##
# Load the Unfollower class
load 'lib/unfollower.rb'

directory 'tasks'

task default: %w(help)

task :help do
  puts ''
  puts '- `rake followers[number]` -- write latest followers to a text file.'
  puts '- `rake spam` -- blocks/reports for spam users in that text file.'
  puts '- `rake block` -- blocks the users in that text file.'
  puts ''
  puts 'Usage: rake <followers, spam, block>'
end

task :followers, [:arg1] do |_t, args|
  if args[:arg1].to_i > 0
    Unfollower.follower_list(args[:arg1].to_i)
  else
    Unfollower.follower_list
  end
end

task :spam do
  assholes = Unfollower.assholes
  Unfollower.block_assholes(assholes, true)
end

task :block do
  assholes = Unfollower.assholes
  Unfollower.block_assholes(assholes, false)
end
