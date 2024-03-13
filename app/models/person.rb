# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  has_many :details, inverse_of: :person, dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true

  validates_associated :details
  validates :name, presence: true
end
