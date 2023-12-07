class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :category_id, null: false
      t.string :name, null: false
      t.integer :value, null: false
      t.timestamps
    end
  end
end
