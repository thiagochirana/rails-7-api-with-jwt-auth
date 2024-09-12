class ApplicationController < ActionController::API
  before_action :authenticate_user

  def authenticate_user
    token = request.headers["Authorization"]
    render json: { message: "Realize um novo login para prosseguir" }, status: :unauthorized unless token
    decoded_token = JwtService.decode(token.split(" ").last) if token

    @current_user = User.find_by(id: decoded_token[:sub]) if decoded_token
  rescue JWT::ExpiredSignature
    render json: { message: "Realize um novo login para prosseguir, use o refresh_token" }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { message: "Não foi possível validar o token: #{e.message}" }, status: :unauthorized
  end
end
