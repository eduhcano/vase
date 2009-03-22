class AvatarsController < ApplicationController
  before_filter :require_user
  before_filter :setup

  def edit
    render
  end

  def update
    respond_to do |format|
      if @avatar.update_attributes(params[:avatar])
        flash[:notice] = t("controllers.avatars.successfully_updated")
        format.html { redirect_to avatar_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @avatar.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    flash[:error] = t("controllers.avatars.successfully_deleted")
  end

  private

  def setup
    @avatar = @p.avatar
    if @avatar.nil? or @p != @avatar.profile
      flash[:error] = t("controllers.avatars.wayttd")
      redirect_to root_url
    end
  end
end
