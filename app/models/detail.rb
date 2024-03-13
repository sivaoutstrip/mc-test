# frozen_string_literal: true

class Detail < ApplicationRecord
  belongs_to :person, inverse_of: :details

  validates :email, presence: true, uniqueness: true, on: :create
end
