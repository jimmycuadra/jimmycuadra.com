module UsersHelper
  def user_avatar(user)
    default_avatar_url = "http://www.gravatar.com/avatar/00000000000000000000000000000000?s=48"

    avatar_url = case
    when user.email
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?s=48"
    when user.avatar
      user.avatar
    end

    "<img src=\"#{avatar_url || default_avatar_url}\" width=\"48\" height=\"48\" alt=\"#{user.name}'s avatar\" />".html_safe
  end
end
