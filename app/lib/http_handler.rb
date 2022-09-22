module HttpHandler
  def http_exception_handler(message, status = 500)
    render json: { error: { message: }, is_success: false }, status:
  end

  def error_handler(exception)
    logger.error exception.message
    logger.error exception.backtrace.join('\n')
    render json: { error: { message: 'Internal Server Error' }, is_success: false }, status: 500
  end

  def success_handler(response, status = 200)
    render json: { data: response, is_success: true }, status:
  end
end
