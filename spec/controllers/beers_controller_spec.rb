require 'spec_helper'

describe BeersController do

  describe "GET 'root'" do
    it "should be successful" do
      get 'root'
      response.should be_success
    end
  end

  describe "GET 'kind'" do
    it "should be successful" do
      get 'kind'
      response.should be_success
    end
  end

end
