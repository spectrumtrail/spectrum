class Admin::ProfileController < Admin::BaseController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to(
        admin_profile_path,
        success: "Successfully updated your profile."
      )
    else
      flash[:danger] = "We could not update your profile. See errors."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
