class StaffController < ApplicationController
  before_action :authenticate_user!
  before_action :over_staff_limit, only: %i( new create )

  include ActionView::Helpers::UrlHelper

  def index
  end

  def new
    @page_title = 'New Staff Member'
  end

  def create
  end

  private

    def over_staff_limit
      if current_org.staff.count >= current_org.staff_limit
        flash[:warning] = "You have reached your staff limit of #{current_org.staff_limit}. Need to #{link_to('upgrade your account?', upgrade_organisation_path, class: 'alert-link')}"
        redirect_to staff_index_path
      end
    end
end
