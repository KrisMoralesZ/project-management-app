Rails.application.routes.draw do
  root "welcome#index"

  resources :projects do
    get "members/search", to: "project_members#search"
    post "members/search", to: "project_members#search", as: :search_members
    post "members/add", to: "project_members#add", as: :add_member

    resources :artifacts do
      resources :comments, only: %i[create destroy]
    end
  end

  post "go_to_organization", to: "welcome#redirect_to_subdomain"

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
