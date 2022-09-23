class AddUniqueConstraint < ActiveRecord::Migration[7.0]
  def change
    add_index :authors, :email, unique: true
  end
end
