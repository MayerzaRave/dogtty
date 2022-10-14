class CreateDeseases < ActiveRecord::Migration[7.0]
  def change
    create_table :deseases do |t|
      t.string :name
      t.date :at_age
      t.text :treatment
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
