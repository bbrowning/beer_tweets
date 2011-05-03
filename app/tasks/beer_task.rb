class BeerTask < TorqueBox::Messaging::Task

  def create_from_json(payload)
    Beer.create_from_json(payload[:tweet])
  end

end
