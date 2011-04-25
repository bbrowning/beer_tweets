BeerTweets::Application.routes.draw do
  match "kind/:kind" => "beers#kind", :constraints => { :kind => /.*/ }, :as => :beer_kind
  root :to => "beers#root"
end
