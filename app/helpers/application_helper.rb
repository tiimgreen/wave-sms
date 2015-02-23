module ApplicationHelper
  # Decides class of header
  def header_class
    on_page('pages', 'home') ? 'navbar navbar-inverse hero':  'navbar navbar-inverse normal'
  end

  # Short method for checking if on certain page
  def on_page(given_controller_name, given_action_name)
    controller.controller_name == given_controller_name &&
    controller.action_name == given_action_name
  end

  def page_title(short, long = 'Wave SMS')
    short.present? ? "#{short} | #{long}" : long
  end
end
