class Admin::SponsorsController < Admin::BaseController
  before_action :set_sponsor, only: [:edit, :update, :destroy]

  def index
    @sponsors = Sponsor.order(:name)
  end

  def new
    @sponsor = Sponsor.new
  end

  def edit
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to admin_sponsors_path, success: "Created #{@sponsor.name}!"
    else
      render :new
    end
  end

  def update
    if @sponsor.update(sponsor_params)
      redirect_to @sponsor, success: "Updated #{@sponsor.name}!"
    else
      render :edit
    end
  end

  def destroy
    @sponsor.destroy
    redirect_to admin_sponsors_path, success: "Sponsor was successfully destroyed."
  end

  private
    def set_sponsor
      @sponsor = Sponsor.friendly.find(params[:id])
    end

    def sponsor_params
      params.require(:sponsor).permit!
    end
end
