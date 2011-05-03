class BeersController < ApplicationController

  caches_action :most_popular, :expires_in => 30.seconds

  def most_popular
    @popular_beers = Beer.most_popular(:limit => 25)
  end

end
