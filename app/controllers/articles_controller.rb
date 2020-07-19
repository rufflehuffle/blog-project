class ArticlesController < ApplicationController
    include ArticlesHelper

    before_action :require_login, only: [:new, :create, :destroy, :edit, :update]

    def index
        @articles = Article.all
        @articles = @articles.each { |article| article.view_count = 0 if article.view_count.nil? }
        @most_popular_articles = @articles.sort_by { |article| article.view_count }.reverse.take(10)
    end

    def show
        @article = Article.find(params[:id])

        @article.view_count = 0 if @article.view_count.nil?
        @article.view_count += 1

        @article.save

        @comment = Comment.new
        @comment.article_id = @article.id
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.save

        flash.notice = "Article '#{@article.title}' created!"

        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        flash.notice = "Article '#{@article.title}' deleted!"

        redirect_to articles_path
    end

    def edit
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        @article.update(article_params)

        flash.notice = "Article '#{@article.title}' updated!"
        
        redirect_to article_path(@article)
    end
end
