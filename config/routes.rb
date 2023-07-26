Rails.application.routes.draw do
  
  get '/', to: 'articles#index', as:'root'
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/articles', to: 'articles#index'
  get '/articles/new', to: 'articles#new', as: 'new_article'
  post '/articles'   , to: 'articles#create'
  get '/articles/:id', to: 'articles#show', as: 'article'
  get '/articles/:id/edit', to: 'articles#edit' , as: 'edit_article'
  patch '/articles/:id', to: 'articles#update'
  delete '/articles/:id', to: 'articles#destroy'


  resources :articles do
    resources :comments, only: [:create]
      end
      
  resources :comments, only: [:destroy]


  resource :users, except: [:destroy, :show] do
    collection do
      get :login 
      post :logining
      delete :logout
    end     
  end    
  
  
  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          patch :like
        end
      end
    end
  end
  


end
