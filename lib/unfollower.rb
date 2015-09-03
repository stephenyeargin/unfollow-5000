##
# Unfollower5000
class Unfollower

  @output_file = 'assholes.txt'

  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret     = ENV['TWIITER_CONSUMER_SECRET']
    config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  ##
  # Get Assholes
  def self.get_assholes
    throw 'There was not a file to load.' unless File.exists?(@output_file)
    assholes = []
    File.open(@output_file, 'r') do |io|
      io.each_line do |line|
        assholes << line.strip
      end
    end
    assholes
  end

  ##
  # Blocks assholes
  def self.block_assholes(assholes=[], report_spam=true)
    throw 'Not an array.' if assholes.class != Array
    for asshole in assholes
      puts "Blocking #{asshole} ..."
      @client.report_spam(asshole) if report_spam
      @client.block(asshole)
      sleep(3)
    end
  rescue StandardError => e
    puts e
  end

  ##
  # Gets your last 100 followers and write them to a file
  def self.get_follower_list(limit=100)
    puts "Getting #{limit} of most recent followers."
    File.open(@output_file, "w") do |io|
      @client.followers.take(limit).each do |follower|
        puts follower.screen_name
        io.write "#{follower.screen_name}\n"
        sleep(1)
      end
    end
  end
end
