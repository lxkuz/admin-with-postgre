Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'statics#index'
    resources :locales, only: :index

    namespace :admin do
      root 'dashboard#index'
      get '/', to: redirect('admin/dashboard')
      get :dashboard, to: 'dashboard#index'

      resources :pictures, only: [:index, :create, :show, :destroy]
      resources :attachments, only: [:index, :create, :destroy]

      resources :users
    end

    # Devise routes and overrides
    devise_for :users, 
    controllers: {
      :sessions => "admin/sessions",
    },
    path_names: {
      :sign_in      => 'login',
      :sign_out     => 'logout',
      :confirmation => 'confirm',
      :unlock       => 'unlock',
      :registration => 'register',
      :invitation   => 'invite'
    }
  end
end
