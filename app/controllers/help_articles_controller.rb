class HelpArticlesController < ApplicationController
  def index
    @help_articles = HelpArticle.all

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @help_articles }
    end
  end

  def show
    @help_article = HelpArticle.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @help_article }
    end
  end
  
  def new
    @help_article = HelpArticle.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @help_article }
    end
  end
 
  def edit
    @help_article = HelpArticle.find(params[:id])
  end

  def create
    @help_article = HelpArticle.new(params[:help_article])
    @help_article.help_locations = HelpLocation.find(params[:help_location_ids]) if params[:help_location_ids]  
    respond_to do |format|
      if @help_article.save
        flash[:notice] = 'HelpArticle was successfully created.'
        format.html { redirect_to(@help_article) }
        format.xml  { render :xml => @help_article, :status => :created, :location => @help_article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @help_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @help_article = HelpArticle.find(params[:id])

    respond_to do |format|
      if @help_article.update_attributes(params[:help_article])
        flash[:notice] = 'HelpArticle was successfully updated.'
        format.html { redirect_to(@help_article) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @help_article.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @help_article = HelpArticle.find(params[:id])
    @help_article.destroy

    respond_to do |format|
      format.html { redirect_to(help_articles_url) }
      format.xml  { head :ok }
    end
  end
end
