class SessionsController < ApplicationController
  def destroy
    sign_out(current_user)
    reset_session
    redirect_to root_path
  end
end
