class Profile < ActiveRecord::Base
  # ralations
  belongs_to :user
  
  # avatar
  has_attached_file :avatar, :styles => { :medium => "100x100>", :thumb => "50x50>", :micro => "25x25>" },
    :url  => "/avatars/:id/:style/:basename.:extension",
    :path => ":rails_root/public/avatars/:id/:style/:basename.:extension",
    :default_url => "/images/avatars/:style/missing.png"
    
  def full_name
    [first_name, last_name].delete_if(&:blank?).join(" ")
  end
  
  def full_address
    [address, city_state_zip].delete_if(&:blank?).join(', ')
  end
  
  def brief_location
    [city, state, country].delete_if(&:blank?).join(', ')
  end

  def city_state
    [city, state].delete_if(&:blank?).join(', ')
  end
  
  def city_state_zip
    [city_state, zip].delete_if(&:blank?).join(' ')
  end
end
