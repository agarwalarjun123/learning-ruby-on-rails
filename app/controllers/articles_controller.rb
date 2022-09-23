## Articles Controller for all article related functions
class ArticlesController < ApplicationController
  before_action :authorize?

  def show
    article = Article.find(params[:id])
    success_handler(article)
  end

  def create
    @article = Article.new(article_params)
    @article.author_id = @user.id
    @article.save!
    success_handler @article, :ok
  end

  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    limit = params[:limit].nil? ? 5 : params[:limit].to_i
    articles = Article.where({ authors_id: @user.id }).offset((page - 1) * limit.to_i).limit(limit.to_i)
    @result = { result: articles, metadata: { page:, limit: } }
    success_handler(@result)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
