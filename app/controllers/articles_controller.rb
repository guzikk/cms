class ArticlesController < ApplicationController

  layout 'admin'
  before_action :check_login
  before_action :find_page

  def index
    @articles = @pages.articles.sort
  end

  def delete
    @articles = Article.find(params[:id])
  end

  def destroy
    article = Article.find(params[:id]).destroy
    flash[:notice]= "Article ' #{article.name} ' was deleted"
    redirect_to(:action=>'index', :page_id => @pages.id)
  end


  def edit
    @page = Page.order('position ASC')
    @articles = Article.find(params[:id])
    @counter = Article.count
  end

  def update
    @articles = Article.find(params[:id])
    if @articles.update_attributes(articles_params)
      flash[:notice]= "Article was updated"
      redirect_to(:action => 'show', :id=>@articles.id, :page_id => @pages.id)
    else
      @page = Page.order('position ASC')
      @counter = Article.count
      render('edit')
    end
  end

  def new
    @articles = Article.new({:page_id=>@pages.id})
    @page = Page.order('position ASC')
    @counter = Article.count + 1
  end

  def create
    @articles = Article.new(articles_params)
    if @articles.save
      flash[:notice]= "New article was created"
      redirect_to(:action => 'index', :page_id => @pages.id)
    else
      @page = Page.order('position ASC')
      @counter = Article.count + 1
      render('new')
    end
  end

  def show
    @articles = Article.find(params[:id])
  end

  private
  def articles_params
    params.require(:articles).permit(:page_id, :name, :position, :visible, :created_at, :photo, :content)
  end

  def find_page
    if params[:page_id]
      @pages = Page.find(params[:page_id])
    end
  end

end
