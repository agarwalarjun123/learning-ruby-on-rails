def success_handler(response, status = 200)
  render json: { data: response, is_success: true }, status:
end
