module ContextualHelpHelper
  def contextual_help_link(options = {})
    options[:always_link] ||= false 
    options[:name] ||= 'Help'
    options[:page_tip] ||= false

    if show_link? options[:always_link]
      link_to options[:name], request.request_uri.chomp("/") + "/help" + (options[:page_tip] ? "&page_tip=1" : ''), :id => options[:id], :class => options[:class]
    end
  end

  private
  def show_link?(always_link)
    return false if ['help_article','help_location'].include? controller_name || action_name == 'help'
    return true if always_link
    return HelpArticle.in_use(controller_name, action_name).count > 0
  end
end
