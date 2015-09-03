require 'twitter'
require 'dotenv'

##
# Use dotenv to load configuration
if File.exists?('.env')
  Dotenv.load
else
  throw 'You must first copy your credentials to the .env file.'
end

##
# Load the Unfollower class
load 'lib/unfollower.rb'

directory "tasks"

task default: %w[help]

task :help do
  puts ''
  puts '- `rake followers[number]` -- writes your latest followers to a text file.'
  puts '- `rake spam` -- reports the users in that text file for spam and blocks them (limit of 50 spam reports per day)'
  puts '- `rake block` -- blocks the users in that text file'
  puts ''
  puts 'Usage: rake <followers, spam, block>'
end

task :followers, [:arg1] do |t, args|
  if args[:arg1].to_i > 0
    Unfollower.get_follower_list(count)
  else
    Unfollower.get_follower_list
  end
end

task :spam do
  assholes = Unfollower.get_assholes
  Unfollower.block_assholes(assholes, true)
end

task :block do
  assholes = Unfollower.get_assholes
  Unfollower.block_assholes(assholes, false)
end
