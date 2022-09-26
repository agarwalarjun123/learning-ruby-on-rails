class ApplicationController < ActionController::API
  include ExceptionHandler
  include AuthHandler
  rescue_from ApiException, with: :error_handler
  rescue_from StandardError, with: :error_handler
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotUnique, with: :render_record_not_unique
end
