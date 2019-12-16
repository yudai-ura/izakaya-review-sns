class PhotosController < ApplicationController
    
    def create
      @photo = Photo.new(image_params)
      @photo.save
      redirect_to show
    end
    
private
    
    def image_params
      params.require(:photos).permit(:image)
    end
end
