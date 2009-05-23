class Notifier < ActionMailer::Base
  default_url_options[:host] = APP_CONFIG["domain"]

  def password_reset_instructions(user)        
    setup_email(user.profile.language)                         
    subject       I18n.t("models.notifier.password_reset_instructions")
    recipients    user.email
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token), :app => APP_CONFIG["name"], :contact => APP_CONFIG["contact"]
  end   
  
  def is_following_you(inviter, invited)                                                                              
    setup_email(invited.language)
    subject       I18n.t ("models.notifier.is_following_you", :inviter => inviter, :app => APP_CONFIG["name"])
    recipients    invited.user.email
    body          :inviter => inviter.user.login, :invited => invited.user.login, :profile_url => user_profile_url(inviter.user.login), :app => APP_CONFIG["name"]
  end  
  
  protected
  
  def setup_email(language)
    I18n.locale =   language
    from            "#{APP_CONFIG["url"]} <#{APP_CONFIG["contact"]}>"
    sent_on         Time.now  
    content_type    "text/html" 
  end
end
