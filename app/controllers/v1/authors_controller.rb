module V1
  class AuthorsController < ApplicationController
    before_action :authorize?, only: [:profile]
    def login
      @user = Author.find_by(email: params[:email])
      if @user&.authenticate(params[:password])
        success_handler({ token: @user.generate_token })
      else
        http_exception_handler('Incorrect Credentials', :unauthorized)
      end
    end

    def signup
      @author = Author.new(author_params)
      @author.password = params[:password]
      @author.save! && success_handler({})
    rescue ActiveRecord::RecordNotUnique
      http_exception_handler('User Exists', :bad_request)
    end

    def profile
      success_handler(@user)
    end

    private

    def author_params
      params.require(:author).permit(:name, :email)
    end
  end
end
