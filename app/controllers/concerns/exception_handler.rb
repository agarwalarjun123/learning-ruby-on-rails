module ExceptionHandler
  def render_record_not_found(exception)
    http_exception_handler(exception.message, :bad_request)
  end

  def render_record_invalid(exception)
    http_exception_handler(exception.message, :bad_request)
  end

  def http_exception_handler(message, status = :internal_server_error)
    render json: { error: { message: }, is_success: false }, status:
  end

  def error_handler(exception)
    logger.error exception.message
    logger.error exception.backtrace.join('\n')
    render json: { error: { message: 'Internal Server Error' }, is_success: false }, status: :internal_server_error
  end

  def success_handler(response, status = :ok)
    render json: { data: response, is_success: true }, status:
  end
end
