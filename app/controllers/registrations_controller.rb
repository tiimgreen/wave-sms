class RegistrationsController < Devise::RegistrationsController

  def new
    @page_title = 'Sign Up'
    super
  end

  def create
    redirect_to root_path

    @org = Organisation.new(name: params[:organisation_name])

    if @org.save

      params.delete(:organisation_name)

      build_resource(sign_up_params.merge({ organisation_id: @org.id }))

      resource.save
      yield resource if block_given?
      if resource.persisted?
        @org.update_attributes(owner_id: resource.id)

        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource) and return
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource) and return
        end
      else
        @org.destroy
        clean_up_passwords resource
        respond_with resource and return
      end
    else
      render :new and return
    end
  end

  def edit
    @page_title = 'Edit Account'
    super
  end
end
