class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.string :gender
      t.string :breed
      t.integer :weight
      t.text :bio

      t.timestamps null: false
    end
  end
end
