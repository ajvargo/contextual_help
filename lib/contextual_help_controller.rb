module ContextualHelpController
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
      @help_articles = HelpArticle.in_use(controller_name, params[:rest] || "index")
      render 'shared/help'
    end
  end
end


