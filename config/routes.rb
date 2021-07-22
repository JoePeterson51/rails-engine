Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'items_search#find'
      get '/items/find_all', to: 'items_search#find_all'

      get '/merchants/find', to: 'merchants_search#find'
      get '/merchants/find_all', to: 'merchants_search#find_all'
      get '/merchants/most_items', to: 'merchants_search#most_items'

      get '/revenue/merchants', to: 'revenue#most_revenue'
      get '/revenue/merchants/:id', to: 'revenue#merchant_revenue'
      get '/revenue', to: 'revenue#date_revenue'
      get '/revenue/items', to: 'revenue#top_items_revenue'
      get '/revenue/unshipped', to: 'revenue#unshipped_potential_revenue'

      resources :merchants, only: [:index, :show]

      resources :items

      namespace :merchants do
        get '/:id/items', to: 'merchant_items#index'
      end

      namespace :items do
        get '/:id/merchant', to: 'item_merchants#index'
      end
    end
  end
end
