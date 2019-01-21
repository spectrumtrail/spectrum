class RemoveCourseHtmlFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :course_html, :text
  end
end
