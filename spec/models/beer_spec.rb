require 'spec_helper'

describe Beer do

  it { should have_many :kinds }

  it "should create from JSON" do
    beer = Beer.from_json(File.read("#{::Rails.root}/spec/fixtures/beers.json"))
    beer.text.should == "tweet_text"
    beer.twitter_id.should == "60377907884867584"
    beer.user_id.should == "103266962"
    beer.screen_name.should == "screen_name"
    beer.profile_image_url.should == "http:\/\/a0.twimg.com\/profile_images\/1239459306\/ProfilePhoto_normal.png"
    beer.tweeted_at.should == Time.parse("Tue Apr 19 16:23:09 +0000 2011")
  end

  it "should find words_before" do
    beer = Beer.new
    kinds = beer.send(:words_before, "This is some text", ["some", "text"], 2)
    kinds.count.should == 4

    kinds[0][:keyword].should == "some"
    kinds[0][:word].should == "is"
    kinds[0][:offset].should == 1

    kinds[1][:keyword].should == "some"
    kinds[1][:word].should == "this"
    kinds[1][:offset].should == 2

    kinds[2][:keyword].should == "text"
    kinds[2][:word].should == "some"
    kinds[2][:offset].should == 1

    kinds[3][:keyword].should == "text"
    kinds[3][:word].should == "is"
    kinds[3][:offset].should == 2
  end

  it "should create kinds" do
    beer = Beer.create(:text => "I like beer and need more Beers please")
    beer.index!
    Kind.find_all_by_keyword("beer").size.should == 1
    Kind.find_by_keyword_and_offset("beer", 1).word.should == "like"
    Kind.find_all_by_keyword("beers").size.should == 3
    Kind.find_by_keyword_and_offset("beers", 1).word.should == "more"
  end

  context "split_text" do
    before(:each) { @beer = Beer.new }

    it "should downcase words" do
      @beer.send(:split_text, 'SOME TEXT').should == %w(some text)
    end

    it "should filter out leading hashtags" do
      @beer.send(:split_text, '#some text').should == %w(some text)
    end

    it "should filter out leading mentions" do
      @beer.send(:split_text, '@some @text').should == %w(some text)
    end

    it "should filter out trailing commas" do
      @beer.send(:split_text, 'some, text').should == %w(some text)
    end

    it "should filter out emoticons" do
      @beer.send(:split_text, 'some text :) :-) :D LOL').should == %w(some text lol)
    end

    it "should filter out one-letter words" do
      @beer.send(:split_text, 'a b c some text').should == %w(some text)
    end

    it "should filter out url words" do
      @beer.send(:split_text, 'http://a.com https://b.com some text').should == %w(some text)
    end
  end
end
