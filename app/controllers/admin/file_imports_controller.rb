class Admin::FileImportsController < Admin::BaseController
  def new
    @file_import = FileImport.new
  end

  def create
    @file_import = FileImport.new(file_import_params)
    if @file_import.save
      redirect_to admin_dashboard_path, success: "File Import succeeded."
    else
      render :new
    end
  end

  def file_import_params
    params.require(:file_import).permit!
  end
end
