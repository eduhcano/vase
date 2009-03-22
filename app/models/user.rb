class User < ActiveRecord::Base
  # relations
  has_one :profile, :dependent => :destroy
    
  # authlogic  
  acts_as_authentic :login_field_validation_options => {:if => :openid_identifier_blank?}, :password_field_validation_options => {:if => :openid_identifier_blank?}
  
  # validates
  validate :normalize_openid_identifier
  validates_uniqueness_of :openid_identifier, :allow_blank => true
  
  def to_s
    self.login
  end
  
  def after_create
    build_profile
  end
  
  def after_destroy
    profile.destroy
  end

  def openid_identifier_blank?
    openid_identifier.blank?
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end

  private

  def normalize_openid_identifier
    begin
      self.openid_identifier = OpenIdAuthentication.normalize_url(openid_identifier) if !openid_identifier.blank?
    rescue OpenIdAuthentication::InvalidOpenId => e
      errors.add(:openid_identifier, e.message)
    end
  end
end
