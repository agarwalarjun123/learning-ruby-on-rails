## Articles Controller for all article related functions
require_relative '../lib/api_handler/http_error_handler'
require_relative '../lib/api_handler/success_handler'
class ArticlesController < ApplicationController
  include HttpErrorHandler
  rescue_from StandardError, with: :error_handler
  def index
    render json: { message: 'hello world' }
  end

  def show
    article = Article.find(params[:id])
    success_handler(article)
  rescue ActiveRecord::RecordNotFound
    http_exception_handler('Article Not Found', 404)
  end

  def create
    @article = Article.new(article_params)
    @article.save!
    success_handler @article, :ok
  end

  def page
    page = params[:page].nil? ? 1 : params[:page].to_i
    limit = params[:limit].nil? ? 5 : params[:limit].to_i
    articles = Article.all.offset((page - 1) * limit.to_i).limit(limit.to_i)
    @result = { result: articles, metadata: { page:, limit: } }
    success_handler(@result)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
