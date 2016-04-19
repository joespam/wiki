class ArticlesController < ApplicationController

	before_action :find_article, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:show, :index]

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def destroy
		@article.destroy
		redirect_to root_path
	end

	def edit
	end

	def index
		if params[:category].blank?
			@articles = Article.all.order("title ASC")
		else 
			@category_id = Category.find_by(name: params[:category]).id
			@articles = Article.where(category_id: @category_id).order("title ASC")
		end
	end

	def new
		@article = current_user.articles.build 
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :content, :category_id)
	end

	def find_article
		@article = Article.find(params[:id])
	end

end
