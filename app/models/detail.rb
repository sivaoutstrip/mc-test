# frozen_string_literal: true

class Detail < ApplicationRecord
  belongs_to :person, inverse_of: :details

  enum title: { 'Dr.': 'Dr.', 'Mr.': 'Mr.', 'Mrs.': 'Mrs.', 'Prof.': 'Prof.' }

  validates :email, presence: true, uniqueness: true, on: :create
  validates :title, inclusion: { in: titles.values }, allow_nil: true
end
