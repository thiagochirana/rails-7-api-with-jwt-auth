class RegistrationService
  def self.registrate(params)
    return self.json("não se pode registrar novo usuario sem dados", :bad_request) unless params
    return self.json("preencha o primeiro nome, obrigatório", :bad_request) unless params[:firstname]
    return self.json("preencha o email, obrigatório", :bad_request) unless params[:email]
    return self.json("preencha a senha, obrigatório", :bad_request) unless params[:password]

    user = User.new params
    if user.save
      return self.json("Usuario cadastrado com sucesso", :created)
    end
    self.json("Usuario não pode ser cadastrado, cheque os campos", :bad_request)
  end

  def self.update_user(user, params)
    return self.json("Não é possível atualizar o usuario", :bad_request) if params[:email] != user[:email]
    if user.update params
      return self.json("Atualizado com sucesso", :ok)
    end
    self.json("houve erro na atualizacao do usuario", :ok)
  end

  def self.json(message, status)
    { message:, status: }
  end
end
