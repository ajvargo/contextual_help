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
      if params[:page_tip] then
        @help_articles = HelpArticle.page_tips.in_use(controller_name, params[:rest] || "index")
      else
        @help_articles = HelpArticle.in_use(controller_name, params[:rest] || "index")
      end
      respond_to do |format|
        format.html { render 'shared/help' }
        format.xml  { render :xml => @help_articles }
        format.json { render :json => @help_articles }
      end
    end
  end
end


