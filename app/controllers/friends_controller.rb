class FriendsController < ApplicationController
  # filters
  before_filter :require_user
  
  def create
    @invited = User.find_by_login(params[:login]).profile
    @conn = Friend.do_friends(@p, @invited)
    
    respond_to do |format|
      if @conn
        flash[:notice] = t("controllers.friends.is_your_friend", :friend => @invited.user.login)
        format.html { redirect_to user_profile_path(@invited.user.login) }
        format.xml  { render :xml => @conn, :status => :created }
      else
        format.html { redirect_to(@invited) }
        format.xml  { render :xml => @conn.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @invited = User.find_by_login(params[:login]).profile

    respond_to do |format|
      if @conn = Friend.break(@p, @invited)
        flash[:notice] = t("controllers.friends.is_not_your_friend", :friend => @invited.user.login)
        format.html { redirect_to user_profile_path(@invited.user.login) }
        format.xml  { head :ok }
      end
    end
  end
end
