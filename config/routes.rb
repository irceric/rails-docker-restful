Rails.application.routes.draw do
  resources :members do
    resources :tags
  end
end
