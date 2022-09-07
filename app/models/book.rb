# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :episodes, dependent: :destroy
end
