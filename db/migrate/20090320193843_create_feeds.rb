class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.integer   :profile_id
      t.integer   :feed_item_id
    end
  end

  def self.down
    drop_table :feeds
  end
end
