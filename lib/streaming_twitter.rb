class StreamingTwitter

  def initialize(username, password)
    @username = username
    @password = password
  end

  def search(term)
    EventMachine::run {
      stream = Twitter::JSONStream.connect(:path => '/1/statuses/filter.json',
                                           :auth => "#{@username}:#{@password}",
                                           :method => 'POST',
                                           :content => "track=#{term}")
      stream.each_item do |item|
        yield item
      end

      stream.on_error do |message|
        puts "error: #{message}"
      end

      stream.on_reconnect do |timeout, retries|
        puts "reconnecting in: #{timeout} seconds"
      end

      stream.on_max_reconnects do |timeout, retries|
        puts "failed after #{retries} failed reconnects"
      end
    }
  end

  def disconnect
    EventMachine.stop if EventMachine.reactor_running?
  end

end
