class PhotosController < ApplicationController
  layout 'admin'
  before_action :check_login
  before_action :find_gallery

  def index
    @photo = @galleries.photos.sort
  end

  def new
    @photo=Photo.new({:gallery_id=>@galleries.id})
    @counter = Photo.count+1
    @gallery = Gallery.sort
  end

  def create
    @photo=Photo.new(photo_params)
    if @photo.save
      flash[:notice] = "Photo was upload to database"
      redirect_to(:action=>'index', :gallery_id=>@galleries.id)
    else
      @counter = Photo.count+1
      @gallery = Gallery.sort
      render('new')
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @gallery = Gallery.find(@photo.gallery_id)
  end

  def delete
    @photo = Photo.find(params[:id])
  end

  def destroy
    photo = Photo.find(params[:id]).destroy
    flash[:notice] = "photo #{photo.name} was deleted"
    redirect_to(:action=>'index', :gallery_id=>@galleries.id)
  end

  def edit
    @photo = Photo.find(params[:id])
    @counter = Photo.count
    @gallery = Gallery.sort
  end


  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(photo_params)
      flash[:notice]="photo '#{@photo.name}' was updated"
      redirect_to(:action=>'show', :id=>@photo.id, :gallery_id=>@galleries.id)
    else
      @counter = Photo.count
      @gallery = Gallery.sort
      render('edit')
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:gallery_id, :name, :position, :visible, :photo, :description,:created_at)
  end

  def find_gallery
    if params[:gallery_id]
      @galleries = Gallery.find(params[:gallery_id])
    end
  end

end
