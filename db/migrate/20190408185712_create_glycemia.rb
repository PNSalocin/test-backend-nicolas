class CreateGlycemia < ActiveRecord::Migration[5.2]
  def change
    create_table :glycemia do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :measurement, null: false
      t.timestamp :taken_at, null: false
      t.timestamps
    end
  end
end
