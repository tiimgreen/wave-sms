class OrganisationsController < ApplicationController
  before_action :authenticate_org_owner, only: :edit

  def index
  end

  def show
  end

  def edit
    @org = Organisation.find(params[:id])
  end

  def update
    @org = Organisation.find(params[:id])

    if @org.update_attributes(organisation_params)
      flash[:success] = 'Organisation updated'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

    def authenticate_org_owner
      @org = Organisation.find(params[:id])

      unless current_user == @org.owner
        flash[:warning] = 'You need to be the organisation owner to do that.'
        redirect_to dashboard_path
      end
    end

    def organisation_params
      params.require(:organisation).permit(:name, :area_code)
    end
end
