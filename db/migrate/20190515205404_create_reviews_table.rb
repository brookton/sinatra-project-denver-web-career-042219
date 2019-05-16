class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
        t.references :restaurant
        t.references :user
        t.integer :rating
    end
  end
end
