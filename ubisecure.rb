require 'oauth2'
require 'byebug'

BASE_SCOPE_URL = 'https://10.81.24.124:8443'.freeze
AUTHORIZE_URL = '/uas/oauth2/authorization'.freeze
TOKEN_URL = '/uas/oauth2/token'.freeze
REDIRECT_URL = 'http://localhost:3000/user/auth/ubisecure/callback'.freeze
DEFAULT_SCOPE = 'userinfo'.freeze
DEFAULT_RESPONSE = 'code'.freeze

oauth_json = {
  client_id: '4qhzx9b846jrzm28uib8c1tk7de3bz1b66g0',
  client_secret: '67568a22ee7c2a82e30e32dcdcb0c5d81948282f70ea9a9b'
}

options = {
  site: BASE_SCOPE_URL,
  scope: DEFAULT_SCOPE,
  token_url: TOKEN_URL,
  authorize_url: AUTHORIZE_URL
}

authorize_params = {
  response_type: DEFAULT_RESPONSE,
  redirect_uri: REDIRECT_URL
}

client = OAuth2::Client.new(oauth_json[:client_id],
                            oauth_json[:client_secret],
                            options)

client.auth_code.authorize_url({ redirect_uri: REDIRECT_URL }.merge(authorize_params))
client.connection.ssl.verify = false
byebug

client.get

byebug

token = client.auth_code.get_token('authorization_code_value',
                                   options[:redirect_uri],
                                   headers: { 'Authorization' => '' })

response = token.get(BASE_SCOPE_URL, params: { 'query_foo' => 'bar' })
