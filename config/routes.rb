Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :health, only: [:index]

  scope '/:enterprise_subdomain' do
    namespace :api, path: "" do
      namespace :v1 do
        namespace :users do
          resources :sign_in, only: [:create]
          resources :forgot_password, only: [:create]
        end
      end
    end
  end
end
