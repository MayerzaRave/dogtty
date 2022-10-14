class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :specie
      t.date :birthday
      t.float :weight
      t.string :weight_unit
      t.string :breed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
