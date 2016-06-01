class AddPetReferenceToPictures < ActiveRecord::Migration
  def change
    add_reference :pictures, :pet, index: true, foreign_key: true
  end
end
