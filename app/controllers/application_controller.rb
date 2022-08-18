class ApplicationController < ActionController::Base
    def disable_nav
        @disabled_nav = true
    end
end
