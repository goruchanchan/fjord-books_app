class RegistrationsController < Devise::RegistrationsController

  protected
    # https://github.com/heartcombo/devise/wiki/How-To:-Customize-the-redirect-after-a-user-edits-their-profile
    def after_update_path_for(resource)
      user_path(resource)
    end
end
