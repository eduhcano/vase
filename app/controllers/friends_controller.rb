class FriendsController < ApplicationController
  # filters
  before_filter :require_user, :setup
  
  def create
    @conn = Friend.do_friends(@inviter, @invited)
    
    if @conn
      flash.now[:notice] = "is now your friend"
    else
      flash.now[:error] = "Sorry, something goes wrong"
    end
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @conn }
    end
  end

  def destroy
  end
  
  protected
  
  def setup
    @inviter = @p.user
    @invited = Profile.find(params[:profile_id]).user
  end
end
