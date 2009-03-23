module FriendsHelper
  def friend_link(inviter, invited)
    return link_to(t("views.friends.log_in_to_follow"), login_path) if inviter.blank?
    return '' if !(inviter && invited) or (inviter.id == invited.id)
    return link_to(t("helpers.friends.stop", :invited => invited.user.login), break_path(invited.user.login), :method => :delete) if invited.followed_by?(inviter)
    link_to(t("helpers.friends.start", :invited => invited.user.login), confirm_path(invited.user.login), :method => :post)
  end
end
