class AddReviewToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :review, :string
  end
end
