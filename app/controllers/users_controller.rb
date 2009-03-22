class UsersController < ApplicationController
  # filters
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = t("controllers.users.registered")
      redirect_back_or_default edit_profile_path(@user.profile)
    else
      render :action => :new
    end
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = t("controllers.users.updated")
      redirect_to password_path
    else
      render :action => :edit
    end
  end
end
