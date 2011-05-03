class Beer < ActiveRecord::Base
  has_many :kinds

  class << self; include TorqueBox::Messaging::Backgroundable; end

  KEYWORDS = ['beer', 'beers']

  def self.create_from_json(text)
    json = ActiveSupport::JSON.decode(text)
    beer = Beer.new(:text => json["text"],
                    :twitter_id => json["id_str"],
                    :tweeted_at => Time.parse(json["created_at"]),
                    :user_id => json["user"]["id_str"],
                    :screen_name => json["user"]["screen_name"],
                    :profile_image_url => json["user"]["profile_image_url"])
    beer.save!
    beer.index!
  end

  def self.most_popular(options={})
    max_offset = options[:max_offset] || 2
    limit = options[:limit] || 25
    Kind.top_by_keyword(KEYWORDS, max_offset, limit).map { |kind, count| kind }
  end

  def index!
    # Create Kinds up to 3 offset aways
    kinds.create(words_before(text, KEYWORDS, 3))
  end

  def self.clean_older_than(amount)
    Beer.where('created_at < ?', amount.ago).delete_all
  end

  protected

  def words_before(text, keywords, max_offset)
    matches = []
    words = split_text(text)
    words.each_with_index do |word, index|
      word = word.downcase
      if keywords.include?(word)
        # Found a keyword, calculate offset for each word preceding it
        (1..index).each do |offset|
          matches << {
            :keyword => word,
            :word => words[index - offset].downcase,
            :offset => offset } if offset <= max_offset
        end
      end
    end
    matches
  end

  def split_text(text)
    words = text.split
    words = words.map do |word|
      word = word.downcase
      word = word.gsub(/[^\w]*$/, '')
      word = word.gsub(/^[^\w]*/, '')
    end
    words.select do |word|
      word.length > 1 && (word =~ /^http/) == nil
    end
  end
end
