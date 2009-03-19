class ProfilesController < ApplicationController
  # filters
  before_filter :setup
  before_filter :require_user, :except => :show
  
  def show
    @profile = Profile.find(params[:id])
    @followings = @profile.followings.find(:all, :order => "random()")
    @followers = @profile.followers.find(:all, :order => "random()")
    
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
        flash[:notice] = 'Your profile was successfully updated'
        format.html { redirect_to edit_profile_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @p.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  
  def setup
    @profile = @p
  end
end
