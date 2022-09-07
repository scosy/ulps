# frozen_string_literal: true

class CreateFilledOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :filled_orders do |t|
      t.integer :user_id
      t.string :checkout_session_id

      t.timestamps
    end
  end
end
