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
end
