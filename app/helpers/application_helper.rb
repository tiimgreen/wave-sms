module ApplicationHelper
  # Decides class of header
  def header_class
    on_page('pages', 'home') ? 'navbar navbar-inverse hero':  'navbar navbar-inverse normal'
  end

  # Short method for checking if on certain page
  def on_page(cont, act)
    controller.controller_name == cont.downcase &&
    controller.action_name == act.downcase
  end

  def page_title(short, long = 'Wave SMS')
    short.present? ? "#{short} | #{long}" : long
  end

  def current_org
    user_signed_in? ? current_user.organisation : nil
  end

  def on_organisation_branding_page?
    on_page('organisations', 'new_customer')
  end

  # rubocop:disable ColonMethodCall
  # Returns the Gravatar (http://gravatar.com/) for the given user
  def gravatar_for(user, options = { size: 50, circle: false, class: '' })
    size = options[:size]
    if user.email.present?
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    else
      url = "http://free-online-marketing-lessons.com/wp-content/uploads/2014/08/Gravatar-icon.png"
    end

    class_names = ['gravatar ' + options[:class].to_s]

    options[:circle] ? class_names.push('img-circle') :
                       class_names.push('img-rounded')

    image_tag(url, alt: user.name, class: class_names.join(' '), width: size, height: size)
  end
end
