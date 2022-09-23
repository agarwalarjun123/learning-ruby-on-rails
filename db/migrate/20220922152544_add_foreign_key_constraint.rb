class AddForeignKeyConstraint < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :authors, foreign_key: true
  end
end
