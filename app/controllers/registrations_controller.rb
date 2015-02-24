class RegistrationsController < Devise::RegistrationsController

  def new
    super
    @page_title = 'Test'
  end

  def create
    redirect_to root_path

    @org = Organisation.create!(name: params[:organisation_name])

    params.delete(:organisation_name)

    build_resource(sign_up_params.merge({ organisation_id: @org.id }))

    resource_saved = resource.save
    yield resource if block_given?
    if resource.persisted?
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, resource)
      redirect_to(dashboard_path) and return
    else
      @org.destroy
      clean_up_passwords resource
      render :new
    end
  end
end
