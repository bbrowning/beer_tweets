class CreateBeers < ActiveRecord::Migration
  def self.up
    create_table :beers do |t|
      t.string :text
      t.string :twitter_id
      t.string :user_id
      t.string :screen_name
      t.string :profile_image_url
      t.datetime :tweeted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :beers
  end
end
