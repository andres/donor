Rails.application.routes.draw do

  resources :session
  resources :users
  resources :people do
    collection do
      get 'search'
    end
  end
  resources :campaigns
  resources :donations

  root to: "session#index"

  resources :reports, only: [:index, :show] do
    collection do 
      get 'download'
    end
  end

end

