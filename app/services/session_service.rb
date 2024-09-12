class SessionService
  def self.authenticate params
    login = params[:login]
    pass = params[:password]
    return self.token_h("Falta preencher login ou senha", :bad_request) if login.empty? || pass.empty?

    user = User.find_by("email = :login OR nickname = :login", login: login)
    if user&.authenticate(pass)
      user.tracking_login
      user.save

      access_token = JwtService.encode({ sub: user.id }, 20.minutes.from_now)
      refresh_token = JwtService.encode({ sub: user.id }, 1.days.from_now)
      return self.token_h("Login realizado com sucesso", :ok, access_token:, refresh_token:)
    end
    self.token_h("Login ou Senha inválidos", :unauthorized)
  end

  def self.refresh refresh_token
    decoded_token = JwtService.decode(refresh_token)
    if decoded_token
      access_token = JwtService.encode({ sub: decoded_token[:sub] })
      return self.token_h("Relogado com sucesso", :ok, access_token:, refresh_token:)
    end
    self.token_h("Não é possível continuar com login", :unauthorized)
  rescue JWT::DecodeError
    self.token_h("Não é possível continuar com login", :unauthorized)
  rescue JWT::ExpiredSignature
    self.token_h("Realize um novo login para prosseguir", :unauthorized)
  end

  def self.token_h(message, status, access_token: nil, refresh_token: nil)
    { access_token:, refresh_token:, status:, message: }
  end
end
