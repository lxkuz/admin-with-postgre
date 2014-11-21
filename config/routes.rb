Rails.application.routes.draw do
  root 'statics#index'

  namespace :admin do
    root 'dashboard#index'
    get '/', to: redirect('admin/dashboard')
    get :dashboard, to: 'dashboard#index'

    resources :users
  end

  # devise routes and overrides
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
