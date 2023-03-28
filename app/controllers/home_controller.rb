class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  layout "application"
  def home
    if current_user
      redirect_to dashboard_path
    end
  end

  def dashboard

  end
end
