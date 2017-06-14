Rails.application.routes.draw do
  get 'review' => 'review#index'
  post 'review/search' => 'review#search'
  get 'review/search' => 'review#search'
  get 'review/:book_id' => 'review#show'
  patch 'review/:book_id' => 'review#update_read_status'
  get 'tag_api' => 'tag_api#index'
  post 'tag_api/add' => 'tag_api#add'
  post 'tag_api/remove' => 'tag_api#remove'

  root 'top#index'

  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
