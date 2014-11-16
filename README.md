# Moocher

Makes API requests (no auth, basic auth and oauth2).

When testing an API which used OAuth2 for authentication we had to make multiple requests to retreive a token to then make a request with.
`Moocher` performs the OAuth2 authentication itself.

Define Connections:
- Choose a type of Connection
- Set required parameters
  - No Auth
    - Endpoint to make request on
  - Basic Auth
    - Endpoint to make request on
    - Username & Password
  - OAuth2
    - Endpoint to make requests on
    - Client Id & Secret
    - Choose a Strategy
      - Username & Password for Password Strategy

Define Request:
- Set path & method
- Choose Connection
- Set Header & Parameter variables
- Make Request
- Response is displayed

Implements OAuth2 (Client Credentials and Password) in JavaScript, see [`app/assets/javascripts/app/lib/oauth2`](app/assets/javascripts/app/lib/oauth2).

Demo: https://moocher.herokuapp.com

## TODO
- [ ] Allow Parameters to be added as JSON
- [ ] Implement Parameter as File
- [ ] Response body display type (Plain text, HTML, JSON, ...)
- [ ] Import/Export Connections
- [ ] Import/Export Requests
- [ ] Styling

## Documentation
### Deployment
Included Rake task to deploy to Heroku:
`bundle exec rake heroku:deploy`
Compiles assets before pushing.
