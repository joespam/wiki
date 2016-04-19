class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def index
	end

	def new
		@article = Article.new
	end

	private

	def article_params
		params.require(:article).permit(:title, :content)
	end

	def get_article
		@article = Article.find(params[:id])
	end

end
