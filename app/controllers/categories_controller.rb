class CategoriesController < ApplicationController

  layout 'admin'
  before_action :check_login

  def index
    @category = Category.sort
    @pages = Page.count
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
    @counter = Category.count + 1
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice]= "New category was created"
      redirect_to(:action => 'index')
    else
      @counter = Category.count + 1
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
    @counter = Category.count
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice]= "Category was updated"
      redirect_to(:action => 'show', :id=>@category.id)
    else
      @counter = Category.count
      render('edit')
    end
  end

  def delete
    @category = Category.find(params[:id])
  end

  def destroy
    category = Category.find(params[:id]).destroy
    flash[:notice]= "Category #{category} was deleted"
    redirect_to(:action=>'index')
  end

  private
  def category_params
    params.require(:category).permit(:name, :position, :visible, :created_at)
  end

end
