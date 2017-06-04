class CreateFollowers < ActiveRecord::Migration[5.1]
  def change
    create_table :followers do |t|
      t.string :twitter_id
      t.string :name

      t.timestamps
    end
    add_index :followers, :twitter_id, unique: true
  end
end
