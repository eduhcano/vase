class Feed < ActiveRecord::Base
  # relations
  belongs_to :feed_item, :dependent => :destroy
  belongs_to :profile
end
