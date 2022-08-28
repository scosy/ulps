module ApplicationHelper
    def markdown(text)
        options = %i[
            hard_wrap autolink no_intra_emphasis tables fenced_code_blocks
            disable_indented_code_blocks strikethrough lax_spacing space_after_headers
            quote footnotes highlight underline
        ]
        Markdown.new(text, *options).to_html.html_safe
    end

    def flash_class(level)
        case level
            when "notice" then "alert alert-primary"
            when "success" then "alert alert-success"
            when "error" then "alert alert-danger"
            when "alert" then "alert alert-warning"
        end
    end

    def user_ability_with(episode)
        return "start_trial" if !current_user

        has_episode = current_user.episodes.include?(episode)
        has_credits = current_user.available_credits > 0

        return "see_episode" if has_episode
        return "start_trial" if !current_user.subscribed?
        return "get_credits" if !has_credits && !has_episode
        return "buy_episode" if has_credits && !has_episode
    end

    def proper_global_cta
        return "start_trial" if !current_user

        has_credits = current_user.available_credits > 0

        return "start_trial" if !current_user.subscribed?
        return "none" if has_credits
        return "get_credits" if !has_credits
    end
end
