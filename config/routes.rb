Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/preauth/spotify", to: "sessions#spotify_preauth"
  get "/auth/spotify/callback", to: "sessions#spotify_callback"
end
