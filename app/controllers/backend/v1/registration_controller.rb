class Backend::V1::RegistrationController < ApplicationController
  skip_before_action :authenticate_user, only: :sign_up

  def sign_up
    r = RegistrationService.registrate registration_params
    render json: r, status: r[:status]
  end

  def update_user
    r = RegistrationService.update_user(@current_user, registration_params)
    render json: r, status: r[:status]
  end

  private

  def registration_params
    params.require(:user).permit(:firstname, :lastname, :nickname, :email, :password)
  end
end
