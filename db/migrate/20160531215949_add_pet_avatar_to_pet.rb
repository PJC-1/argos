class AddPetAvatarToPet < ActiveRecord::Migration
  def change
    add_column :pets, :pet_avatar, :string
  end
end
