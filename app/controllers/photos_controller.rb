class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, exept: %i[ index show ]
  before_action :owner, only: %i[ edit update destroy ]

  def index
    @photos = Photo.all.order("created_at DESC").paginate(page: params[:page], per_page: 6)
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
      redirect_to @photo, notice: t("controllers.photos.created")
    else
      render :new
    end
  end

  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: t("controllers.photos.updated")
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy

    redirect_to photos_url, notice: t("controllers.photos.destroy")
  end

  private

  def owner
    @photo = current_user.photos.find_by(id: params[:id])

    redirect_to photos_path, notice: t("controllers.photos.update_error") if @photo.nil?
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
end
