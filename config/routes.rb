BeerTweets::Application.routes.draw do
  root :to => "beers#most_popular"
end
