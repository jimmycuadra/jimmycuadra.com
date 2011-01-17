module UsersHelper
  def user_avatar(user)
    puts "user.avatar: #{user.avatar}"
    puts "user.email: #{user.email}"

    default_avatar_url = "http://www.gravatar.com/avatar/00000000000000000000000000000000?s=48"

    avatar_url = case
    when user.avatar
      user.avatar
    when user.email
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?s=48"
    end

    "<img src=\"#{avatar_url || default_avatar_url}\" width=\"48\" height=\"48\" alt=\"#{user.name}'s avatar\" />".html_safe
  end
end
