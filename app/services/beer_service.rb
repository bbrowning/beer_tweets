class BeerService
  
  def initialize
    @username = ENV['TWITTER_USERNAME']
    @password = ENV['TWITTER_PASSWORD']
  end

  def start
    @stream = nil
    Thread.new { run }
  end

  def stop
    @stream.stop unless @stream.nil?
    EventMachine.stop if EventMachine.reactor_running?
  end

  protected

  def run
    EventMachine::run {
      begin
      @stream = Twitter::JSONStream.connect(:path => '/1/statuses/filter.json',
                                            :auth => '#{@username}:#{@password}',
                                            :method => 'POST',
                                            :content => 'track=beer'
                                            )

      @stream.each_item do |item|
        beer = Beer.from_json(item)
        beer.save!
        beer.index!
      end

      @stream.on_error do |message|
        puts "error: #{message}"
      end

      @stream.on_reconnect do |timeout, retries|
        puts "reconnecting in: #{timeout} seconds"
      end

      @stream.on_max_reconnects do |timeout, retries|
        puts "failed after #{retries} failed reconnects"
        end
        
      rescue Exception => ex
        puts ex.inspect
        puts ex.backtrace
      end
    }
  end
end
