module FeedItemsHelper
  def message_for(feed_item, recent = false)
    item = feed_item.item
    case item.class.name
    when "Profile"
      "#{link_to item.user.login, profile_path(feed_item.item)} has updated his avatar"
    end
  end
end