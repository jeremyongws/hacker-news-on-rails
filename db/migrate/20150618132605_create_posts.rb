class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :post_desc
      t.belongs_to :user
      
      t.timestamps null: false
    end
  end
end
