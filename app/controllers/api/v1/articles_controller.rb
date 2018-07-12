module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order('created_at DESC');
        render json: { status: 'Successfullly send', message: 'Loaded Articles', data:articles }, status: :ok
      end

      def show
        article = Article.find_by(id: params[:id])

        if article.nil?
          render json: { status: "Failure something", message: 'Not found', data: [] }, status: :not_found
          return
        end
        render json: { status: 'Success', message: 'Loaded Article', data: article }, status: :ok
      end

      def create
        article = Article.new(article_params)
        if article.save
          render json: { status: 'Success', message: 'Saved Article', data: article}, status: :ok
        else
          render json: { status: 'Error', message: 'Article not saved', data: article.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        article = Article.find(params[:id])
        article.destroy
        render json: { status: 'Success', message: 'Deleted Article', data: article  }, status: :ok
      end

      def update
        article = Article.find(params[:id])
        if article.update_attributes(article_params)
          render json: { status: "Success", message: "Updated Successfullly", data: article} ,status: :ok
        else
          render json: { status: "Failure", message: "Article not updated ", data: article.errors} ,status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.permit(:title,:body)
      end

    end
  end
end
