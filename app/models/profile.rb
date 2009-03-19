class Profile < ActiveRecord::Base
  # ralations
  belongs_to :user
  has_many :friendships, :class_name  => "Friend", :foreign_key => 'inviter_id', :conditions => "status = #{Friend::ACCEPTED}", :dependent => :destroy
  has_many :follower_friends, :class_name => "Friend", :foreign_key => "invited_id", :conditions => "status = #{Friend::PENDING}", :dependent => :destroy
  has_many :following_friends, :class_name => "Friend", :foreign_key => "inviter_id", :conditions => "status = #{Friend::PENDING}", :dependent => :destroy
  has_many :friends,   :through => :friendships, :source => :invited
  has_many :followers, :through => :follower_friends, :source => :inviter
  has_many :followings, :through => :following_friends, :source => :invited
  
  # avatar
  has_attached_file :avatar, :styles => { :medium => "100x100#", :thumb => "50x50#", :micro => "25x25#" },
    :url  => "/avatars/:id/:style/:basename.:extension",
    :path => ":rails_root/public/avatars/:id/:style/:basename.:extension",
    :default_url => "/images/avatars/:style/missing.png"
    
  def website=(address)
    write_attribute(:website, fix_http(address))
  end
    
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
  
  # Friend Methods
  def friend_of? user
    friends.include? user
  end
  
  def followed_by? user
    followers.include? user
  end
  
  def following? user
    followings.include? user
  end
  
  protected
  
  def fix_http str
    return '' if str.blank?
    str.starts_with?('http') ? str : "http://#{str}"
  end
end
