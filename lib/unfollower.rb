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
  def self.assholes
    throw 'There was not a file to load.' unless File.exist?(@output_file)
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
  def self.block(assholes = [], report_spam = true)
    throw 'Not an array.' if assholes.class != Array
    assholes.each do |asshole|
      puts "Blocking #{asshole} ..."
      @client.report_spam(asshole) if report_spam
      @client.block(asshole)
      sleep(2)
    end
  rescue StandardError => e
    puts e
  end

  ##
  # Gets your last X followers and write them to a file
  def self.followers(limit = 100)
    puts "Getting #{limit} of most recent followers."
    File.open(@output_file, 'w') do |io|
      @client.followers.take(limit).each do |f|
        if f.following?
          puts "[Skipping #{f.screen_name}]"
          next
        end
        puts "#{f.screen_name}"
        puts "\tCreated #{f.created_at} :: #{f.description} :: #{f.website}"
        io.write "#{f.screen_name}\n"
        sleep(1)
      end
    end
  rescue StandardError => e
    puts e
  end

  ##
  # Generate Block List
  def self.blocked
    puts 'Writing block list to text file.'
    File.open(@output_file, 'w') do |io|
      @client.blocked.each do |b|
        puts b.screen_name
        io.write "#{b.screen_name}\n"
        sleep(1)
      end
    end
  rescue StandardError => e
    puts e
  end
end
