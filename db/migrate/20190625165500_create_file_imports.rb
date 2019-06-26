class CreateFileImports < ActiveRecord::Migration[5.2]
  def change
    create_table :file_imports do |t|
      t.string :name

      t.timestamps
    end
  end
end
