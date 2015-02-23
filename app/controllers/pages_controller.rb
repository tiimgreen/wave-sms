class PagesController < ApplicationController
  before_action :dashboard_redirect

  def home
  end

  def pricing
  end

  def about
  end

  def contact
  end

  private

    def dashboard_redirect
      redirect_to dashboard_path if user_signed_in?
    end
end
