class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  helper_method :current_user_session, :current_user, :set_profile, :locales
  filter_parameter_logging :password, :password_confirmation

  before_filter :set_profile
  
  # rescues
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from NoMethodError, :with => :render_404
  rescue_from ActionView::TemplateError, :with => :render_404

  def set_profile
    @p = current_user.profile if current_user && current_user.profile
    I18n.locale = @p && @p.language ? @p.language : extract_locale_from_accept_language_header
    Time.zone = @p && @p.time_zone ? @p.time_zone : "UTC"
  end
  
  def locales
    {'en' => 'en', 'es' => 'es'}
  end

  private
  
  def extract_locale_from_accept_language_header
    lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    locales.include?(lang) ? lang : 'en'
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:error] = t("controllers.application.you_must_be_logged_in")
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:error] = t("controllers.application.you_must_be_logged_out")
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def render_404(exception)
    render :template => 'errors/404'
  end
end
