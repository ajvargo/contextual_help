module ContextualHelpHelper
  def contextual_help_link
    unless (
            !['help_article','help_location'].include? controller_name &&
            action_name != "help" &&
            HelpArticle.help_article_count(controller_name, action_name) < 1
            )
      link_to 'Help', request.request_uri.chomp("/") + "/help"
    end
  end
end
