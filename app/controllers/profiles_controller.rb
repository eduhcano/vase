class ProfilesController < ApplicationController
  # filters
  before_filter :setup, :except => :show
  before_filter :require_user, :except => :show
  
  def show
    @profile = User.find_by_login(params[:login]).profile
    @followings, @followers = @profile.followings, @profile.followers
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @p }
    end
  end
  
  def edit
    render
  end
  
  def update
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = t("controllers.profiles.successfully_updated") 
        format.html { redirect_to settings_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  
  def setup
    @profile = @p
  end
end
