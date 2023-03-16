class HomeController < ApplicationController
  def index
    @application = Doorkeeper::Application.find_by(name: "React Client")

    @application = {
      name: @application.name,
      client_id: @application.uid,
      client_secret: @application.secret
    }
  end
end