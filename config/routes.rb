require "sidekiq/web"

Rails.application.routes.draw do
  get "/preauth/spotify", to: "sessions#spotify_preauth"
  get "/auth/spotify/callback", to: "sessions#spotify_callback"

  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  mount Sidekiq::Web => "/sidekiq"
end
