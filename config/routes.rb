# frozen_string_literal: true

Rails.application.routes.draw do
  get "/" => redirect("/products/")

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index create]
    end
  end
end


