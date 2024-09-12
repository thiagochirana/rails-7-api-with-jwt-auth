Rails.application.routes.draw do
  namespace :backend do
    namespace :v1 do
      put "registration/update_user"
      post "registration/sign_up"

      post "session/sign_in"
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
