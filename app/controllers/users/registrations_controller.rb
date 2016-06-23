class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        if resource.active_for_authentication?
          flash[:notice] = :signed_up
          sign_up(resource_name, resource)
          respond_to do |format|
            format.html { respond_with resource, location: after_sign_up_path_for(resource) }
            format.js { redirect_via_turbolinks_to root_path }
          end
        else
          flash[:notice] = :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_to do |format|
            format.html { respond_with resource, location: after_inactive_sign_up_path_for(resource) }
            format.js { redirect_via_turbolinks_to root_path }
          end
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_to do |format|
          format.html { respond_with resource }
          format.js { render :new }
        end
      end
      return
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        flash[:notice] = flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_to do |format|
        format.html { respond_with(resource, location: after_update_path_for(resource)) }
        format.js { redirect_via_turbolinks_to root_path }
      end
    else
      clean_up_passwords resource
      respond_to do |format|
        format.html { respond_with(resource) }
        format.js { render :edit }
      end
    end
  end
end
