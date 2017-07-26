Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :messages, only: :index
  match 'webhook' => 'webhook#handle', via: [:get, :post]
end
