# frozen_string_literal: true

class RemoveCheckoutSessionIdFromFilledOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :filled_orders, :checkout_session_id, :string
  end
end
