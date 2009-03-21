class Avatar < ActiveRecord::Base
  # include
  include FeedLogger

  # relation
  belongs_to :profile

  # avatar
  has_attached_file :image, :styles => { :medium => "100x100#", :thumb => "50x50#", :micro => "25x25#" },
    :url  => "/avatars/:id/:style/:basename.:extension",
    :path => ":rails_root/public/avatars/:id/:style/:basename.:extension",
    :default_url => "/images/avatars/:style/missing.png"

  protected

  def create_feed
    add_feed(:item => self, :profile => self) if image_file_name_changed?
  end
end
