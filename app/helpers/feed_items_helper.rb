module FeedItemsHelper
  def message_for(feed_item, recent = false)
    item = feed_item.item
    case item.class.name
    when "Profile"
      "#{link_to item.profile.user, user_profile_path(item.profile.user.login)} has updated his profile"
    when "Avatar"
      "#{link_to item.profile.user, user_profile_path(item.profile.user.login)} has changed his avatar"
    when "Friend"
      inviter = item.inviter.user
      invited = item.invited.user
      "#{link_to inviter, user_profile_path(inviter.login)} and #{link_to invited, user_profile_path(invited.login)} are friends"
    end
  end
end