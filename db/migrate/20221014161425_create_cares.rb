class CreateCares < ActiveRecord::Migration[7.0]
  def change
    create_table :cares do |t|
      t.string :category
      t.date :schedule
      t.string :status
      t.string :title
      t.text :details
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
