class Notifier < ActionMailer::Base
  default_url_options[:host] = APP_CONFIG["app_domain"]

  def password_reset_instructions(user)        
    setup_email                         
    #I18n.locale = user.language
    subject       t("models.notifier.password_reset_instructions")
    recipients    user.email
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token), :app => APP_CONFIG["app_name"], :contact => APP_CONFIG["app_contact"]
  end   
  
  def is_following_you(inviter, invited)                                                                              
    setup_email
    #I18n.locale = invited.language
    subject       I18n.t ("models.notifier.is_following_you", :inviter => inviter, :app => APP_CONFIG["app_name"])
    recipients    invited.user.email
    body          :inviter => inviter.user.login, :invited => invited.user.login, :profile_url => user_profile_url(inviter.user.login), :app => APP_CONFIG["app_name"]
  end  
  
  protected
  
  def setup_email
    from            "#{APP_CONFIG["app_url"]} <#{APP_CONFIG["app_contact"]}>"
    sent_on         Time.now  
    content_type    "text/html" 
  end
end
