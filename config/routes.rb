Rails.application.routes.draw do
  get 'review' => 'review#index'
  post 'review/search' => 'review#search'
  get 'review/mylist' => 'review#mylist'

  get 'review/:book_id' => 'review#show'
  patch 'review/:book_id' => 'review#update_read_status'

  root 'top#index'

  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
