class SessionsController < Devise::SessionsController

  def new
    @page_title = 'Sign In'
    super
  end
end
