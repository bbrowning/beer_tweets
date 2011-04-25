class Kind < ActiveRecord::Base
  belongs_to :beer

  EXCLUDED_WORDS = %W(ah and any are at be but for have having in is it
                      me my of on or our rt that the to with you your)

  def self.top_by_keyword(keywords, max_offset, limit)
    offset_column = connection.quote_column_name("offset")
    query = "keyword IN (?) AND #{offset_column} IN (?) AND length(word) > 1 " +
      "AND word NOT IN (?)"

    results = where(query,keywords, (1..max_offset), EXCLUDED_WORDS).
      group("word").order("count_all DESC").limit(limit).count
  end
end
