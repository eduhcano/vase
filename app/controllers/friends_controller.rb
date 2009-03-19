class FriendsController < ApplicationController
  # filters
  before_filter :require_user
  
  def create
    @invited = Profile.find(params[:profile_id])
    @conn = Friend.do_friends(@p, @invited)
    
    respond_to do |format|
      if @conn
        flash[:notice] = "#{@invited.user.login} is now your friend"
        format.html { redirect_to(@invited) }
        format.xml  { render :xml => @conn, :status => :created }
      else
        format.html { redirect_to(@invited) }
        format.xml  { render :xml => @conn.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @invited = Profile.find(params[:id])
    @conn = Friend.break(@p, @invited)

    respond_to do |format|
      format.html { redirect_to(@invited) }
      format.xml  { head :ok }
    end
  end
end
