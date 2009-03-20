class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.integer   :item_id
      t.string    :item_type
      t.datetime  :created_at
    end
  end

  def self.down
    drop_table :feed_items
  end
end
