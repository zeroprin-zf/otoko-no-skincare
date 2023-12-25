class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :category_id, null: false
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :value, null: false
      t.text :review, null: false
      t.string :star, null: false
      #進捗次第でおすすめ度を入れる
      t.timestamps
    end
  end
end
