class GalleriesController < ApplicationController

  layout 'admin'
  before_action :check_login

  def index
    @galleries = Gallery.sort
  end

  def new
    @gallery = Gallery.new
    @counter = Gallery.count + 1
  end

  def create
    @gallery =  Gallery.new(galleries_params)
    if @gallery.save
      flash[:notice] = "Gallery was created"
      redirect_to(:action => "index")
    else
      @counter = Gallery.count + 1
      render ('new')
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def delete
    @gallery = Gallery.find(params[:id])
  end

  def destroy
    gallery = Gallery.find(params[:id]).destroy
    flash[:notice] = "Gallery '#{gallery.name}' was deleted"
    redirect_to(:action=>'index')
  end

  def edit
    @gallery = Gallery.find(params[:id])
    @counter = Gallery.count
  end

  def update
    @gallery = Gallery.find(params[:id])
    @gallery.update_attributes(galleries_params)
    if @gallery.save
      flash[:notice] = "Galeria '#{@gallery.name}' was updated"
      redirect_to(:action=>'show', :id=>@gallery.id)
    else
      @counter = Gallery.count
      render ('edit')
    end
  end

  private
  def galleries_params
  params.require(:gallery).permit(:name, :position, :visible, :description, :photo)
  end

end
