class ArticlesController < ApplicationController
  def index
    render json: { message: 'hello world' }
  end

  def standard_exception(message, status)
    render json: { error: { message: }, is_success: false }, status:
  end

  def article
    article = Article.find(params[:id])
    render json: article
  rescue ActiveRecord::RecordNotFound
    standard_exception('Not Found', 404)
  end

  def create
    @article = Article.create!(article_params)
    render json: @article
  end

  def page
    page = params[:page].nil? ? 1 : params[:page].to_i
    limit = params[:limit].nil? ? 5 : params[:limit].to_i
    articles = Article.all.offset((page - 1) * limit.to_i).limit(limit.to_i)
    @result = { result: articles, metadata: { page:, limit: } }
    render json: @result
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
