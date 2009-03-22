module FeedItemsHelper
  def message_for(feed_item, recent = false)
    item = feed_item.item
    case item.class.name
    when "Profile"
      t("helpers.feed_items.profile", :login => (link_to item.profile.user, user_profile_path(item.profile.user.login)))
    when "Avatar"
      t("helpers.feed_items.avatar", :login => (link_to item.profile.user, user_profile_path(item.profile.user.login)))
    when "Friend"
      inviter = item.inviter.user
      invited = item.invited.user
      t("helpers.feed_items.are_friends", :inviter => (link_to inviter, user_profile_path(inviter.login)), 
        :invited => (link_to invited, user_profile_path(invited.login)))
    end
  end
end