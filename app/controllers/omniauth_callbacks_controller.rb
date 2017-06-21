class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback "facebook"
  end

  def generic_callback provider
    @identity = Identity.find_for_oauth env["omniauth.auth"]

    @user = @identity.user || current_user

    if @user.nil?
      @user = User.create email: @identity.email || ""
      @identity.update_attributes user_id: @user.id
    end

    @user = @user.match_with @identity

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if
        is_navigational_format?
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
