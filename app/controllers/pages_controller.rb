class PagesController < ApplicationController

  layout 'admin'
  before_action :check_login
  before_action :find_category


  def index
    @pages = @categories.pages.sort
  end

  def edit
    @category = Category.order('position ASC')
    @page = @categories.pages.sort
    @page = Page.find(params[:id])
    @counter = Page.count
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(pages_params)
      flash[:notice]= "Page was updated"
      redirect_to(:action => 'show', :id=>@page.id, :category_id=>@categories.id)
    else
      @category = Category.order('position ASC')
      @counter = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice]= "Page ' #{page.name} ' was deleted"
    redirect_to(:action=>'index', :category_id=>@categories.id)
  end

  def show
    @page= Page.find(params[:id])
    @category_name = Category.find(@page.category_id)
  end

  def new
    @page = Page.new({:category_id=>@categories.id})
    @counter = Page.count + 1
    @category = Category.order('position ASC')
  end

  def create
    @pages = Page.new(pages_params)
    if @pages.save
      flash[:notice]= "New page was created"
      redirect_to(:action => 'index', :category_id=>@categories.id)
    else
      @category = Category.order('position ASC')
      @counter = Page.count + 1
      render('new')
    end
  end

  private
  def pages_params
    params.require(:page).permit(:category_id, :name, :position, :visible, :created_at)
  end

  def find_category
    if params[:category_id]
      @categories = Category.find(params[:category_id])
    end
  end

end
