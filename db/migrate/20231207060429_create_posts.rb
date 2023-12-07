class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :item_id, null: false
      t.text :review, null: false
      #進捗次第でおすすめ度を入れる
      t.timestamps
    end
  end
end
