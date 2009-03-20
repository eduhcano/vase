class Feed < ActiveRecord::Base
  # relations
  belongs_to :feed_item
  belongs_to :profile
end
