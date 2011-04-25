# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110421144835) do

  create_table "beers", :force => true do |t|
    t.string   "text"
    t.string   "twitter_id"
    t.string   "user_id"
    t.string   "screen_name"
    t.string   "profile_image_url"
    t.datetime "tweeted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kinds", :force => true do |t|
    t.string   "keyword"
    t.string   "word"
    t.integer  "offset",     :limit => 10
    t.integer  "beer_id",    :limit => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kinds", ["keyword", "word", "offset"], :name => "index_kinds_on_keyword_and_word_and_offset"

end
