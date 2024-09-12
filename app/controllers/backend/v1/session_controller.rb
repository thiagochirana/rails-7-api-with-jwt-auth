class Backend::V1::SessionController < ApplicationController
  skip_before_action :authenticate_user, only: :sign_in

  def sign_in
    s = SessionService.authenticate session_params
    render json: s, status: s[:status]
  end

  private

  def session_params
    params.require(:user).permit(:login, :password)
  end
end
