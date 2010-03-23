class HelpLocationsController < ApplicationController
  def index
    @help_locations = HelpLocation.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @help_locations }
    end
  end

  def show
    @help_location = HelpLocation.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @help_location }
    end
  end

  def new
    @help_location = HelpLocation.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @help_location = HelpLocation.find(params[:id])
  end

  def create  
    ActionController::Routing::Routes.routes.each do |r| 
      unless (['help_articles', 'help_locations'].include? r.defaults[:controller]) || (['help','update','create','destroy'].include? r.defaults[:action])
        HelpLocation.find_or_initialize_by_action_and_controller( :action => r.defaults[:action], :controller => r.defaults[:controller]).save
      end
    end
    redirect_to help_locations_path
  end

  def update
    @help_location = HelpLocation.find(params[:id])

    respond_to do |format|
      if @help_location.update_attributes(params[:help_location])
        flash[:notice] = 'Help Location was successfully updated.'
        format.html { redirect_to(@help_location) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @help_location.errors, :status => :unprocessable_entity }
      end
    end
  end

end
