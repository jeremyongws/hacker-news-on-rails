class CreatePostsVotes < ActiveRecord::Migration
  def change
    create_table :posts_votes do |t|
      t.belongs_to :post
      t.belongs_to :user
      t.integer :vote

      t.timestamps null: false
    end
  end
end
