class Notifier < ActionMailer::Base
  default_url_options[:host] = APP_CONFIG["app_domain"]

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "#{APP_CONFIG["app_url"]} <noreply@correquetepillo.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end  
end
