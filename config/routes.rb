Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :health, only: [:index]

  scope '/:enterprise_subdomain' do
    namespace :api, path: "" do
      namespace :v1 do

        namespace :enterprises, path: 'enterprise' do
          resources :setting, only: [:index]
          resources :profile, only: [:index]
          resources :subdomain, only: [:index]
          resources :update, param: :token, only: [:update]
        end

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
            get 'all', to: 'all#index'
            put 'update/:token', to: 'update_status#update'
            # resources :update_status, param: 'token', only: [:update]
          end

          namespace :dashboard do
            resources :chart_statuses, only: [:index]
          end
        end

        namespace :suggestions, path: 'suggestion' do
          resources :create, only: [:create]
          resources :list_own, only: [:index]
          resources :list_group_roles, only: [:index]
          resources :detail, param: 'token', only: [:show]

          namespace :files do
            resources :list, param: 'token', path: '', only: [] do
              member do
                get 'list'
              end
            end
          end
        end

        namespace :categories_petitions do
          resources :list, only: [:index]
        end

        namespace :fines do
          namespace :categories do
            resources :list, only: [:index]
            resources :create, only: [:create]
            resources :import, only: [:create]
            resources :delete, only: [:destroy]
          end

          namespace :statuses do
            get 'all/:type', to: 'all#index'
            get 'list/:token', to: 'list#index'
            put 'update/:token', to: 'update_status#update'
          end
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
            resources :remove, path: '', only: [] do
              collection do
                delete 'remove', to: 'remove#delete'
              end
            end
          end
        end

        namespace :properties do
          namespace :statuses do
            get 'all', to: 'all#index'
          end

          namespace :property_types do
            get 'all', to: 'all#index'
          end

          namespace :import do
            resources :template, only: [:index]
            resources :create, only: [:create]
          end

          resources :create, only: [:create]
          resources :update, only: [:update]
          resources :list, only: [:index]
          resources :delete, only: [:destroy]
        end

        namespace :user_properties do
          namespace :import do
            resources :create, only: [:create]
            resources :remove, path: '', only: [] do
              collection do
                delete 'remove', to: 'remove#delete'
              end
            end
          end
        end
      end
    end
  end
end
