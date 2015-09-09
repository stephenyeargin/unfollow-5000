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

task :default do
  system 'rake -sT'
end

desc 'Retrieve list of followers to text file; optional [count]'
task :followers, :count do |_t, args|
  count = args[:count].to_i || 0
  if count == 0
    puts 'How many recent followers to retrieve? (1-100)'
    count = $stdin.gets.chomp.to_i
  end
  if count > 0
    Unfollower.followers(count)
  else
    Unfollower.followers
  end
end

desc 'Block/report users in text file'
task :spam do
  assholes = Unfollower.assholes
  puts 'You will report the following users for spam and block them:'
  puts ''
  puts assholes.join ', '
  puts ''
  puts 'Proceed? [yN]'
  Unfollower.block(assholes, true) if $stdin.gets.chomp.downcase == 'y'
end

desc 'Block users in text file'
task :block do
  assholes = Unfollower.assholes
  puts 'You will block the following users:'
  puts ''
  puts assholes.join ', '
  puts ''
  puts 'Proceed? [yN]'
  Unfollower.block(assholes, false) if $stdin.gets.chomp.downcase == 'y'
end

desc 'Generate a block list [screenname|id]'
task :blocked, :format do |_t, args|
  Unfollower.blocked(args[:format])
end
