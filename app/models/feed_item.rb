class FeedItem < ActiveRecord::Base
  # relations
  belongs_to :item, :polymorphic => true
  has_many :feeds, :dependent => :destroy
  
  # scope
  named_scope :recent, :order => "created_at desc", :limit => 10
  
  def partial
    item.class.name.underscore
  end
end
