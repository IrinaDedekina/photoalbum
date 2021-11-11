class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, exept: %i[ index show ]
  before_action :owner, only: %i[ edit update destroy ]

  def index
    @photos = Photo.all.order("created_at DESC")
  end

  def show
  end

  def new
    @photo = current_user.photos.build
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)

    if @photo.save
      redirect_to @photo, notice: "Photo was successfully created."
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy

    redirect_to photos_url
  end

  private

  def owner
    @photo = current_user.photos.find_by(id: params[:id])

    redirect_to photos_path, notice: "У вас нет разрешения на изменение этой фотографии" if @photo.nil?
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
end
