Rails.application.routes.draw do
  root "welcome#index"

  devise_for :organizations, controllers: {
    registrations: "organizations/registrations",
    sessions: "organizations/sessions"
  }

  devise_for :users, controllers: {
    registrations: "users/registrations",
    invitations: "users/invitations"
  }

  get "dashboard", to: "dashboard#index"

  constraints subdomain: /.+/ do
    scope module: "organizations" do
      resources :users, only: [ :index, :new, :create, :destroy ]
    end
  end
end
