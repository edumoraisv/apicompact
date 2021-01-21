# frozen_string_literal: true

Rails.application.routes.draw do
  post '/upload', to: 'assets#upload'
  post '/graphql', to: 'graphql#execute'

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }
end
