Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      scope module: :merchants do
        resources :merchants, only: [:index, :show] do
          resources :items, only: [:index]
        end
      end
    end
  end
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :show]
    end
  end
end
