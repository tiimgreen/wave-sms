class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_title

  include ApplicationHelper
  include TwilioHelper

  layout :layout_by_resource

  protected

    def set_title
      unless %w( create update destroy ).include?(params[:action].to_s.downcase)

        case params[:action]
        when 'index'
          @page_title = params[:controller].titleize
        when 'show'
          @page_title = params[:controller].singularize.titleize
        when 'new'
          @page_title = "New #{params[:controller].singularize.titleize}"
        when 'edit'
          @page_title = "Edit #{params[:controller].singularize.titleize}"
        else
          @page_title = params[:action].titleize
        end
      end
    end

    def layout_by_resource
      devise_controller? || form_layout? ? 'devise' : 'application'
    end

    def form_layout?
      (params[:controller] == 'organisations' && params[:action] == 'edit') ||
      (params[:controller] == 'customers' && (params[:action] == 'new' || params[:action] == 'create'))
    end
end
