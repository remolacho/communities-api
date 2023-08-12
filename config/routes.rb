Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :health, only: [:index]

  scope '/:enterprise_subdomain' do
    namespace :api, path: "" do
      namespace :v1 do
        namespace :users do
          resources :sign_in, only: [:create]
          resources :list, only: [:index]

          resources :sign_up, only: [:create] do
            collection do
              get 'active/:token', to: 'sign_up#active_account'
            end
          end

          resources :forgot_password, only: [:create] do
            collection do
              get 'verifier/:token', to: 'forgot_password#verifier'
              post 'change/:token', to: 'forgot_password#change'
            end
          end

          resources :profile, only: [] do
            collection do
              get 'show'
            end
          end

          resources :change_status, param: 'token', only: [:show]

          resources :upload_avatar, only: [:create]
        end

        namespace :petitions, path: 'petition' do
          resources :create, only: [:create]
          resources :detail, param: 'token', only: [:show]
          resources :update_status, param: 'token', only: [:update]
          resources :list_own, only: [:index]
          resources :list_group_roles, only: [:index]

          namespace :files do
            resources :list, param: 'token', path: '', only: [] do
              member do
                get 'list'
              end
            end
          end

          namespace :answers, path: 'answer' do
            resources :create, param: 'token', path: '', only: [] do
              member  do
                post 'create', to: 'create#create'
              end
            end

            resources :delete, only: [:destroy]

            namespace :files do
              resources :list, param: 'id', path: '', only: [] do
                member do
                  get 'list'
                end
              end
            end
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
          resources :list_petitions, only: [:index]
        end

        namespace :user_roles do
          namespace :templates do
            resources :import, only: [:index]
          end

          namespace :import do
            resources :create, only: [:create]
          end
        end
      end
    end
  end
end
