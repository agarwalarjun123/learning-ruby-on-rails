class GenerateAuthorTable < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end
  end
end
