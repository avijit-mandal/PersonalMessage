module ApplicationHelper
  def online_status(user)
    content_tag :span, user.name,
              class: "user-#{user.id} online_status #{'online' if user.online?}"
  end

  def gravatar_for(user, opts = {})
    opts[:alt] = user.name
    opts[:class] = "md-user-image"
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
              opts
  end
end
