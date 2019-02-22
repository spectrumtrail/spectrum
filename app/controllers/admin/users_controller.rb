class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.where.not(is_admin: true).order(:name)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(
        admin_users_path,
        success: "Successfully updated #{@user.full_name} "
      )
    else
      flash[:danger] = "We could not create this user. See errors."
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to(
        admin_users_path,
        success: "Successfully updated #{@user.full_name}"
      )
    else
      flash[:danger] = "We could not update this user. See errors."
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to(
      admin_users_path,
      success: "User was successfully removed!"
    )
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
