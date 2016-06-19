class Users::SessionsController < Devise::SessionsController

  def new
    clean_up_passwords(new_user)
    super do
      respond_to do |format|
        format.html { respond_with(resource, serialize_options(resource)) }
        format.js { render 'new' }
      end
      return
    end
  end

  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      sign_in(resource_name, resource)
      redirect_via_turbolinks_to root_path
    else
      flash.now[:danger] = 'Incorrect email or password'
    end
  end

  def destroy
    super { redirect_via_turbolinks_to new_user_session_path and return }
  end

  private

  def new_user
    @user ||= resource_class.new(sign_in_params)
  end

  helper_method :new_user
end
