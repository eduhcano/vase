module FeedLogger
  def add_feed(options = {})
    item = options[:item]
    profile = options[:profile]
    feed_item = FeedItem.create!(:item => item)
    insert_feeds(([profile] + profile.followers), feed_item.id)
  end
  
  private
  
  def values(people, common_value)
    values = []
    values << people.map{|p| "(#{p.id}, #{common_value})"}.join(', ')
  end
  
  def insert_feeds(people, feed_item_id)    
    sql = %(INSERT INTO feeds (profile_id, feed_item_id) 
      VALUES #{values(people, feed_item_id)})
    ActiveRecord::Base.connection.execute(sql)
  end
end