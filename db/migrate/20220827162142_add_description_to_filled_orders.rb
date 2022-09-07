# frozen_string_literal: true

class AddDescriptionToFilledOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :filled_orders, :description, :string
  end
end
