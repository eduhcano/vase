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
  
  # accessors
  attr_accessor :image
  
  def after_create
    build_avatar if avatar.nil?
  end
  
  def image=(uploaded_data)
    unless uploaded_data.blank?
      if avatar.nil?
        self.avatar = Avatar.new(:image => uploaded_data)
      else
        self.avatar.update_attributes(:image => uploaded_data)
      end
      self.avatar.save
    end
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
    # uncomment if you wat to have a new feed each time the user updates his profile
    #add_feed(:item => self, :profile => self)
  end
  
  def fix_http str
    return '' if str.blank?
    str.starts_with?('http') ? str : "http://#{str}"
  end
end
