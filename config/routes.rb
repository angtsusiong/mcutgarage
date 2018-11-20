Rails.application.routes.draw do
  namespace :admin do
      resources :versions do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  namespace :admin do
      resources :requirements do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  namespace :admin do
      resources :resource_categories do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  namespace :admin do
      resources :steps do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  namespace :admin do
      resources :activities do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
          post :projects_for_select2
        end
      end
    end
  namespace :admin do
      resources :pages do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  namespace :admin do
      resources :slides do
        member do
          get :change_show_tab
            get :render_tab_content
            end
      collection do
          post :datatables
          patch :update_row
        get :back
        end
      end
    end
  devise_for :users

  namespace :admin do
    resources :users do
      member do
        get :change_show_tab
        get :render_tab_content
      end

      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end

    resources :project_categories do
      member do
        get :change_show_tab
        get :render_tab_content
      end
      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end

    resources :projects do
      member do
        get :change_show_tab
        get :render_tab_content
        post :change_tab
      end
      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end

    resources :badges do
      member do
        get :change_show_tab
        get :render_tab_content
      end
      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end

    resources :articles do
      member do
        get :change_show_tab
        get :render_tab_content
      end

      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end

    resources :roles do
      member do
        get :change_show_tab
        get :render_tab_content
      end
      collection do
        post :datatables
        patch :update_row
        get :back
        post :resources_for_select2
      end
    end

    resources :related_resources do
      member do
        get :change_show_tab
        get :render_tab_content
      end
      collection do
        post :datatables
        patch :update_row
        get :back
      end
    end
  end # End of namespace

  resources :admins, only: [:index, :edit, :update, :destroy] do
    member do
      get :change_show_tab
      get :render_tab_content
    end

    collection do
      post :datatables
      patch :update_row
      get :back
    end
  end

  resources :users do
    member do
      get :change_show_tab
      get :render_tab_content
    end

    collection do
      post :datatables
      patch :update_row
      get :back
    end
  end

  resources :articles, only: [:index, :new] do
    member do
      get :change_show_tab
      get :render_tab_content
    end

    collection do
      post :datatables
      patch :update_row
      get :back
    end
  end

  resources :projects, only: [:index] do
    member do
      get :change_show_tab
      get :render_tab_content
    end

    collection do
      post :datatables
      patch :update_row
      get :back
    end
  end

  namespace :common do
    namespace :modals do
      get :open
    end
  end

  resources :related_resources, only: [:index] do
    member do
      get :change_show_tab
      get :render_tab_content
    end

    collection do
      post :datatables
      patch :update_row
      get :back
    end
  end

  namespace :common do
    namespace :modals do
      get :open
    end
  end
  root 'mctu_garages#index'
  resources :mctu_garages

  resources :attachments, only: [:index, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
