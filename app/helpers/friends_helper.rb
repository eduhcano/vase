module FriendsHelper
  def friend_link(inviter, invited)
    return link_to 'Sign-up to Follow', new_user_session_path if inviter.blank?
    return '' if !(inviter && invited) or (inviter.id == invited.id)
    link_to 'Stop Being Friends', profile_friend_path(inviter, invited), :method => :delete if inviter.friend_of? invited
    link_to 'Start Following', profile_friends_path(invited), :method => :post
  end
end
