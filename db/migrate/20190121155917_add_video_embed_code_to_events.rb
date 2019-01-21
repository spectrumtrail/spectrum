class AddVideoEmbedCodeToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :video_embed_code, :text
    remove_column :races, :video_embed_code, :text
  end
end
