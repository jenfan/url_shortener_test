Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/urls', to: 'urls#create'
  get '/urls/:slug', to: 'urls#show'
  get '/urls/:slug/stats', to: 'urls#stats'

  # for redirecting from short_url to origin url
  get ':slug', to: 'urls#show'
end
