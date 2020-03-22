# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', controller: :home, action: :index

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index create]
    end
  end
end


