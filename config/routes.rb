Rails.application.routes.draw do
  get '/api/v1/items/find', to: 'api/v1/items_search#find'
  get '/api/v1/items/find_all', to: 'api/v1/items_search#find_all'

  get '/api/v1/merchants/find', to: 'api/v1/merchants_search#find'
  get '/api/v1/merchants/find_all', to: 'api/v1/merchants_search#find_all'
  get '/api/v1/merchants/most_items', to: 'api/v1/merchants_search#most_items'
  get '/api/v1/revenue/merchants', to: 'api/v1/revenue#most_revenue'
  get '/api/v1/revenue/merchants/:id', to: 'api/v1/revenue#merchant_revenue'

  get '/api/v1/revenue', to: 'api/v1/revenue#date_revenue'

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
      scope module: :items do
        resources :items do
          resources :merchant, only: [:index]
        end
      end
    end
  end
end
