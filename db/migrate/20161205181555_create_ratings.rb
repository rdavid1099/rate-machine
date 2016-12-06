class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :product_id
      t.integer :user_id
      t.string :title
      t.string :body
      t.integer :stars, default: 0

      t.timestamps
    end
  end
end
