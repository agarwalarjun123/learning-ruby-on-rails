# rubocop:disable Style/Documentation
module ExceptionHandler
  class ApiException < StandardError
    attr_accessor :status, :message, :data

    def initialize(status, message, data = {})
      self.status = status
      self.message = message
      self.data = data
      super()
    end
  end

  class NotFoundException < ApiException
    def initialize(message, data = {})
      super(:not_found, message, data)
    end
  end

  class BadRequestException < ApiException
    def initialize(message, data = {})
      super(:bad_request, message, data)
    end
  end

  class UnauthorizedException < ApiException
    def initialize(message, data = {})
      super(:unauthorized, message, data)
    end
  end

  def render_record_not_found(exception)
    error_handler(NotFoundException.new(exception.message))
  end

  def render_record_invalid(exception)
    error_handler(BadRequestException.new(exception.message))
  end

  def error_handler(exception)
    if exception.is_a?(ApiException)
      return render json: { error: { message: exception.message }, is_success: false }, status: exception.status
    end

    logger.error exception.message
    logger.error exception.backtrace.join('\n')
    render json: { error: { message: 'Internal Server Error' }, is_success: false }, status: :internal_server_error
  end

  def success_handler(response, status = :ok)
    render json: { data: response, is_success: true }, status:
  end
end
