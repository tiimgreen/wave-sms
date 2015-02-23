class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_title, :dashboard_redirect

  private

    def set_title
      case params[:action]
      when 'index'
        @page_title = params[:controller].titleize
      when 'show'
        @page_title = params[:controller].singularize.titleize
      when 'new'
        @page_title = "New #{params[:controller].singularize.titleize}"
      else
        @page_title = params[:action].titleize
      end
    end

    def dashboard_redirect
      redirect_to dashboard_path if user_signed_in?
    end
end
