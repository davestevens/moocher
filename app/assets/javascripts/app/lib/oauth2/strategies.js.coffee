define [
  "app/lib/oauth2/strategy",
  "app/lib/oauth2/strategies/client_credentials",
  "app/lib/oauth2/strategies/password"
], (Strategy, ClientCredentialsStrategy, PasswordStrategy) ->
  base: Strategy
  client_credentials: ClientCredentialsStrategy
  password: PasswordStrategy
