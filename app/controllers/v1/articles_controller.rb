module V1
  class ArticlesController < ApplicationController
    before_action :authorize?

    def show
      article = Article.find(params[:id])
      success_handler(article)
    end

    def create
      article = Article.new(article_params)
      article.author_id = @user.id
      article.save!
      success_handler article, :ok
    end

    def index
      page = params[:page]&.to_i || 1
      limit = params[:limit]&.to_i || 5
      articles = Article.all.offset((page - 1) * limit).limit(limit)
      result = { result: articles, metadata: { page:, limit:, count: Article.count } }
      success_handler result, :ok
    end

    private

    def article_params
      params.require(:article).permit(:title, :body)
    end
  end
end
