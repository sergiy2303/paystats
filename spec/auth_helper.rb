module AuthHelper
  def http_login
    user = 'admin'
    pw = 'D21tD_##21afhd'
    token = ActionController::HttpAuthentication::Basic.encode_credentials(user, pw)
    request.env['HTTP_AUTHORIZATION'] = token
  end
end