class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  before_action :authenticate_editor!, only: [:edit, :update, :new, :create]
  before_action :authenticate_admin!, only: [:destroy]
  def search
    if params.has_key?(:titulo) && params[:titulo].length > 0
      @articles = Article.titulo(params[:titulo])
    else
      @articles = Article.all
    end

  end
  def new
  	@article = Article.new
    @categories = Category.all
  end

  def index
	@articles = Article.paginate(:page => params[:page], :per_page => 2).ultimos
     if user_signed_in? && current_user.is_editor? && !params.has_key?(:normal)
      render :"admin_article"
     end
  end

  def show
   @comment = Comment.new
  end

  def create
    if params[:categories].nil?
      redirect_to new_article_path, alert:"Necesitas minimo una categoria."
    else
    	@article = current_user.articles.new(article_params)
      @article.categories = params[:categories]
    	respond_to do |format|
  	  	if @article.save
  	  		format.html {redirect_to @article, notice: "Articulo creado correctamente"}
  	  		format.json {render :show, status: :created, location: @article}
  	  	else
  	  		format.html {render :new}
  	  		format.json {render json: @article.errors, status: :unprocessable_entity}
  	  	end
  	  end
    end
  end

  def update
    @article.categories = @article.categories.ids
    	respond_to do |format|
  	  	if @article.update(article_params)
  	  		format.html {redirect_to @article, notice: "Articulo editado correctamente"}
  	  		format.json {render :show, status: :ok, location: @article}
  	  	else
  	  		format.html {render :edit}
  	  		format.json {render json: @article.errors, status: :unprocessable_entity}
  	  	end
	end
  end

  def destroy
  	@article.destroy
  	respond_to do |format|
  		format.html {redirect_to articles_path, notice: "Articulo eliminado"}
  		format.json {head :no_content}
  	end
  end


  private

  def set_article
    begin
  	 @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "El artículo no existe"
    end
  end

  def article_params
  	params.require(:article).permit(:title, :body, :categories, :img_art)
  end
end
