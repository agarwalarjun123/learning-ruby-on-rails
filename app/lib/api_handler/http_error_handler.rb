module HttpErrorHandler
  def http_exception_handler(message, status = 500)
    render json: { error: { message: }, is_success: false }, status:
  end

  def error_handler(exception)
    logger.error exception.message
    logger.error exception.backtrace.join('\n')
    render json: { error: { message: 'Internal Server Error' }, is_success: false }
  end
end
