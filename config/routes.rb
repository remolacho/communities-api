Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :health, only: [:index]

  scope '/:enterprise_subdomain' do
    namespace :api, path: "" do
      namespace :v1 do
        namespace :users do
          resources :sign_in, only: [:create]
          resources :sign_up, only: [:create]

          resources :forgot_password, only: [:create] do
            collection do
              get 'verifier/:token', to: 'forgot_password#verifier'
            end
          end

          resources :profile, only: [] do
            collection do
              get 'show'
            end
          end
        end

        namespace :petitions, path: 'petition' do
          resources :create, only: [:create]
          resources :detail, param: 'token', only: [:show]
          resources :update_status, param: 'token', only: [:update]

          namespace :answers, path: 'answer' do
            resources :create, param: 'token', path: '', only: [] do
              member  do
                post 'create', to: 'create#create'
              end
            end

            resources :delete, only: [:destroy]
          end

          namespace :answers do
            get 'list/:token', to: 'list#index'
          end

          namespace :statuses do
            get 'list/:token', to: 'list#index'
          end
        end

        namespace :categories_petitions do
          resources :list, only: [:index]
        end

        namespace :group_roles do
          resources :list, only: [:index]
        end
      end
    end
  end
end
