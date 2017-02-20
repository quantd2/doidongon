class SessionsController < Devise::SessionsController
  respond_to :js

  def new
    build_resource({})
    super
  end
end
