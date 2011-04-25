# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)


NUM_SEEDS = 20000

(Beer.count..NUM_SEEDS).each do |index|
  puts "Creating beer #{index}"
  beer = Beer.new(:text => "I like beer, you like beer, lets go drink cold beer",
                  :twitter_id => "999",
                  :tweeted_at => Time.now,
                  :user_id => "999",
                  :screen_name => "dummy_user",
                  :profile_image_url => "")
  beer.save!
  beer.index!
end
