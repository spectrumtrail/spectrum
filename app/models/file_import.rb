class FileImport < ApplicationRecord
  has_one_attached :csv_file_to_import
end
