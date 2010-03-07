module ContextualHelp
  def self.included(controller)
    controller.extend ClassMethods
  end
  module ClassMethods
    def contextual_help
      include InstanceMethods
    end
  end

  module InstanceMethods
    def help
      @help_articles = HelpLocation.find_all_by_controller_and_action(controller_name, params[:rest]||"index").collect{|hl| hl.help_articles}.flatten
      render 'shared/help'
    end
  end
end


