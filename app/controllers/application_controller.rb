class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def set_title
      unless %w( create update destroy ).include(params[:action].to_s.lowercase)

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
    end
end
