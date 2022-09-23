class RenameColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :authors, :password, :password_digest
  end
end
