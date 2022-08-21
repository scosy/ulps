class ApplicationController < ActionController::Base
    def disable_nav
        @disabled_nav = true
    end

    def only_admin
        redirect_to root_path unless current_user && current_user.admin?
    end
end
