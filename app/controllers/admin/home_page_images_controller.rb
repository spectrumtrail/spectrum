class Admin::HomePageImagesController < Admin::BaseController
  before_action :set_home_page_image, only: [:edit, :update, :destroy]

  def index
    @home_page_images = HomePageImage.rank(:display_order).all
  end

  def new
    @home_page_image = HomePageImage.new
  end

  def create
    @home_page_image = HomePageImage.new(home_page_image_params)

    if @home_page_image.save
      flash[:success] = "Home Page Image successfully created."
      redirect_to admin_home_page_images_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @home_page_image.update(home_page_image_params)
      flash[:success] = "Successfully updated Home Page Image"
      redirect_to admin_home_page_images_path
    else
      flash[:error] = "Could not update this Home Page Image"
      render :edit
    end
  end

  def destroy
    if @home_page_image.destroy
      flash[:success] = "Successfully removed Home Page Image"
      redirect_to admin_home_page_images_path
    else
      flash[:error] = "Could not destroy this Home Page Image"
      redirect_to admin_home_page_images_path
    end
  end

  private

  def set_home_page_image
    @home_page_image = HomePageImage.find(params[:id])
  end

  def home_page_image_params
    params.require(:home_page_image).permit!
  end
end
