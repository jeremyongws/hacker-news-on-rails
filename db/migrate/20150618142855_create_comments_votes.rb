class CreateCommentsVotes < ActiveRecord::Migration
  def change
    create_table :comments_votes do |t|
      t.belongs_to :comment
      t.belongs_to :user
      t.integer :vote

      t.timestamps null: false
    end
  end
end
