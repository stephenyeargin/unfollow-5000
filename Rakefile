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
  puts '- `rake followers` -- write latest followers to a text file.'
  puts '- `rake spam` -- blocks/reports for spam users in that text file.'
  puts '- `rake block` -- blocks the users in that text file.'
  puts '- `rake blocked` -- export entire blocked list to text file.'
  puts ''
  puts 'Usage: rake <followers, spam, block>'
end

task :followers do
  puts 'How many recent followers to retrieve? (1-100)'
  count = $stdin.gets.chomp.to_i
  if count > 0
    Unfollower.followers(count)
  else
    Unfollower.followers
  end
end

task :spam do
  assholes = Unfollower.assholes
  puts 'You will report the following users for spam and block them:'
  puts ''
  puts assholes.join ', '
  puts ''
  puts 'Proceed? [yN]'
  Unfollower.block(assholes, true) if $stdin.gets.chomp.downcase == 'y'
end

task :block do
  assholes = Unfollower.assholes
  puts 'You will block the following users:'
  puts ''
  puts assholes.join ', '
  puts ''
  puts 'Proceed? [yN]'
  Unfollower.block(assholes, false) if $stdin.gets.chomp.downcase == 'y'
end

task :blocked do
  Unfollower.blocked
end
