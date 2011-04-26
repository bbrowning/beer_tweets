# Be sure to restart your server when you modify this file.

# Configure the TorqueBox Servlet-based session store.
# Provides for server-based, in-memory, cluster-compatible sessions
# BeerTweets::Application.config.session_store TorqueBox::Session::ServletStore if defined?(TorqueBox::Session::ServletStore)

BeerTweets::Application.config.session_store :cookie_store, :key => '_beer_tweets_session'
