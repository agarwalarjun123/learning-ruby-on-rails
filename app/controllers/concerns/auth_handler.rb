module AuthHandler
  def authorize?
    user = JWT.decode(request.headers['Authorization'], 'string')
    @user = Author.find_by(email: user.first['email']) || http_exception_handler('Unauthenticated', :unauthorized)
  rescue StandardError
    http_exception_handler('Unauthenticated', :unauthorized)
  end
end
