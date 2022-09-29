module V1
  class AuthorsController < ApplicationController
    before_action :authorize?, only: [:profile]
    def login
      @user = Author.find_by(email: params[:email])
      return success_handler({ token: @user.generate_token }) if @user&.authenticate(params[:password])
      raise UnauthorizedException, 'Incorrect Credentials'
    end

    def signup
      @author = Author.new(author_params)
      @author.password = params[:password]
      @author.save! && success_handler({})
    rescue ActiveRecord::RecordNotUnique
      raise BadRequestException, 'User Exists'
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
