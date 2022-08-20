class AddAvailableCreditsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :available_credits, :integer, default: 0
  end
end
