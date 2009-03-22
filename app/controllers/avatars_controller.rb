class AvatarsController < ApplicationController
  before_filter :require_user
  before_filter :setup

  def edit
    render
  end

  def update
    respond_to do |format|
      if @avatar.update_attributes(params[:avatar])
        flash[:notice] = 'Your avatar was successfully updated'
        format.html { redirect_to avatar_url }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @avatar.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    flash[:error] = "Successfully deleted..."
  end

  private

  def setup
    @avatar = @p.avatar
    if @avatar.nil? or @p != @avatar.profile
      flash[:error] = "Please, be careful..."
      redirect_to root_url
    end
  end
end
