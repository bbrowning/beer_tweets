class BeerCleaner

  def run()
    Beer.clean_older_than(4.days)
  end

end
