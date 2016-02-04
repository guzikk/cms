class PublicController < ApplicationController

 layout 'public'

  def index
   @page = Page.where(:visible=>true).last(3)
   @article = Article.where(:visible=>true).last(3)
   @gallery = Gallery.where(:visible=>true).last(3)
  end

  def articles
   @page_menu = Page.where(:visible=>true).last(10)
  end

  def galleries
   @gallery = Gallery.find(params[:gallery_id])
  end

  def categories
   @category = Category.find(params[:category_id])
  end

  def news
   @article = Article.find(params[:article_id])
  end

  def page
   @page = Page.find(params[:page_id])
  end

end
