class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_title
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_customers

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
      prettify_controller_forms('organisations') ||
      prettify_controller_forms('customers')
    end

    def prettify_controller_forms(cont)
      params[:controller] == cont &&
      (params[:action] == 'new' || params[:action] == 'create' ||
        params[:action] == 'edit' || params[:action] == 'update')
    end

    def configure_permitted_parameters
      # rubocop:disable Blocks, BlockAlignment, LineLength
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:first_name, :last_name, :email, :password,
                 :password_confirmation, :current_password)
      end
    end

    def set_customers
      @customers_sidebar = current_org.customers.select { |c| c.name.present? }
    end
end
