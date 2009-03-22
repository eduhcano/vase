module FeedItemsHelper
  def message_for(feed_item, recent = false)
    item = feed_item.item
    case item.class.name
    when "Profile"
      "#{link_to item.profile.user.login, user_profile_path(item.profile.user.login)} has updated his profile"
    when "Avatar"
      "#{link_to item.profile.user.login, user_profile_path(item.profile.user.login)} has changed his avatar"
    when "Friend"
      inviter = item.inviter.login
      invited = item.invited.login
      "#{link_to inviter, user_profile_path(inviter)} and #{link_to invited, user_profile_path(invited)} are friends"
    end
  end
end