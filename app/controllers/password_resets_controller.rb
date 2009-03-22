class PasswordResetsController < ApplicationController
  # filters
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  
  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = t("controllers.password.reset")
      redirect_to root_url
    else
      flash[:error] = t("controllers.password.no_user")
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    if @user.save
      flash[:notice] = t("controllers.password.successfully_updated")
      redirect_to edit_profile_path(@user.profile)
    else
      render :action => :edit
    end
  end

  private
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = t("controllers.password.no_perishable_token")  
      redirect_to root_url
    end
  end
end