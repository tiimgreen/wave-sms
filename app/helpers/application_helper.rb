module ApplicationHelper

  # Short method for checking if on certain page
  def on_page(given_controller_name, given_action_name)
    controller.controller_name == given_controller_name &&
    controller.action_name == given_action_name
  end

  def page_title(short, long = 'Wave SMS')
    short.present? ? "#{short} | #{long}" : long
  end
end
