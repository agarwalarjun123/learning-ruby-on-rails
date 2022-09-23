class RenameForeignKey < ActiveRecord::Migration[7.0]
  def change
    rename_column :articles, :authors_id, :author_id
  end
end
