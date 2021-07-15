class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.belongs_to :user, null: false, foreign_key: true, unique: true
      t.belongs_to :post, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
