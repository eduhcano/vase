class UserSessionsController < ApplicationController
  # filters
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    @user_session.save do |result|
      if result
        redirect_back_or_default root_url
      else
        render :action => :new
      end
    end
  end
  
  def destroy
    current_user_session.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = t("controllers.user_sessions.logout_successful")
        redirect_back_or_default login_path 
      }
      format.xml  { head :ok }
    end
  end
end