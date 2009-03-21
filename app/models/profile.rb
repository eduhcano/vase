class Profile < ActiveRecord::Base
  # include
  include FeedLogger
  
  # ralations
  belongs_to :user
  has_many :followings_f, :class_name => "Friend", :foreign_key => "inviter_id", :dependent => :destroy
  has_many :followers_f, :class_name => "Friend", :foreign_key => "invited_id", :dependent => :destroy
  has_many :followings, :through => :followings_f, :source => :invited
  has_many :followers, :through => :followers_f, :source => :inviter
  has_many :feeds
  has_many :feed_items, :through => :feeds, :order => 'created_at desc'
  has_one  :avatar
      
  # callbacks
  after_update :create_feed
  
  def after_create
    build_avatar
  end
  
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
  def following? user
    followings.include? user
  end
  
  def followed_by? user
    followers.include? user
  end
  
  protected
  
  def create_feed
    #add_feed(:item => self, :profile => self) if avatar_file_name_changed?
  end
  
  def fix_http str
    return '' if str.blank?
    str.starts_with?('http') ? str : "http://#{str}"
  end
end
