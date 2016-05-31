Rails.application.routes.draw do

  root 'users#index'

  resources :users do
    resources :pets
  end

  resources :users, only: [] do
    resources :events
  end

  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end


# PETS
# user_pets GET    /users/:user_id/pets(.:format)            pets#index
#      POST   /users/:user_id/pets(.:format)            pets#create
# new_user_pet GET    /users/:user_id/pets/new(.:format)        pets#new
# edit_user_pet GET    /users/:user_id/pets/:id/edit(.:format)   pets#edit
# user_pet GET    /users/:user_id/pets/:id(.:format)        pets#show
#      PATCH  /users/:user_id/pets/:id(.:format)        pets#update
#      PUT    /users/:user_id/pets/:id(.:format)        pets#update
#      DELETE /users/:user_id/pets/:id(.:format)        pets#destroy

# USERS
# root GET    /                                         users#index
# users GET    /users(.:format)                          users#index
#      POST   /users(.:format)                          users#create
# new_user GET    /users/new(.:format)                      users#new
# edit_user GET    /users/:id/edit(.:format)                 users#edit
# user GET    /users/:id(.:format)                      users#show
#      PATCH  /users/:id(.:format)                      users#update
#      PUT    /users/:id(.:format)                      users#update
#      DELETE /users/:id(.:format)                      users#destroy



# EVENTS
# user_events GET    /users/:user_id/events(.:format)          events#index
#      POST   /users/:user_id/events(.:format)          events#create
# new_user_event GET    /users/:user_id/events/new(.:format)      events#new
# edit_user_event GET    /users/:user_id/events/:id/edit(.:format) events#edit
# user_event GET    /users/:user_id/events/:id(.:format)      events#show
#      PATCH  /users/:user_id/events/:id(.:format)      events#update
#      PUT    /users/:user_id/events/:id(.:format)      events#update
#      DELETE /users/:user_id/events/:id(.:format)      events#destroy

# AUTH
# signup GET    /signup(.:format)                         users#new
# login GET    /login(.:format)                          sessions#new
#      POST   /login(.:format)                          sessions#create
# logout GET    /logout(.:format)                         sessions#destroy
