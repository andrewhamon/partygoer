if Rails.env.development?
  GraphiQL::Rails.config.headers['Authorization'] = ->(*) { "Token #{User.first.token}" }
end
