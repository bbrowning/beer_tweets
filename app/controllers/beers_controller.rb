class BeersController < ApplicationController

  def root
    redirect_to beer_kind_path(params[:kind]) and return if request.post?
    @kinds = Beer.top_kinds(:limit => 25)
  end

  def kind
    @kind = params[:kind]
    @beers = Beer.find_by_kind(@kind, :limit => 10)
  end

end
