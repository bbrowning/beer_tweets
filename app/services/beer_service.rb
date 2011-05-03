class BeerService

  def initialize(options)
    @client = StreamingTwitter.new(options["username"], options["password"])
  end

  def start
    Thread.new { find_beer }
  end

  def stop
    @client.disconnect
  end

  protected

  def find_beer
    @client.search('beer') do |tweet|
      Beer.background.create_from_json(tweet)
    end
  end
end
