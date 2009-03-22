module FriendsHelper
  def friend_link(inviter, invited)
    return link_to t("views.friends.log_in_to_follow"), login_path if inviter.blank?
    return '' if !(inviter && invited) or (inviter.id == invited.id)
    return link_to 'Stop Being Friends', profile_friend_path(inviter, invited), :method => :delete if invited.followed_by?(inviter)
    link_to "Start Following", profile_friends_path(invited), :method => :post
  end
end
