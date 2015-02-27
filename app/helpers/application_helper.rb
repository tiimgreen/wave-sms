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
end
