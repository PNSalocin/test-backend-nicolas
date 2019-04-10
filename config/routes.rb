Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :glycemia, only: %i[index]

  resources :users, only: %i[index] do
    resources :glycemia, only: %i[index show create update destroy]
  end
end
