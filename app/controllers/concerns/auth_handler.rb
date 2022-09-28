module AuthHandler
  def authorize?
    user = JWT.decode(request.headers['Authorization'], Rails.configuration.jwt_token)
    @user = Author.find_by(email: user.first['email']) || http_exception_handler('Unauthenticated', :unauthorized)
  rescue StandardError
    raise ExceptionHandler::UnauthorizedException, 'Unauthenticated'
  end
end
