# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  title      :string
#  age        :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Person < ApplicationRecord
  has_many :details, inverse_of: :person, dependent: :destroy
  accepts_nested_attributes_for :details, allow_destroy: true

  normalizes :name, with: ->(name) { name.squish.strip }

  enum title: { 'Dr.': 'Dr.', 'Mr.': 'Mr.', 'Ms.': 'Ms.', 'Mrs.': 'Mrs.', 'Prof.': 'Prof.' }

  validates :name, presence: true, length: { in: 2..72 }
  validates :title, inclusion: { in: titles.values }, allow_nil: true
  validates :age, numericality: { only_integer: true, in: 1..100 }, allow_nil: true
  validates_associated :details
end
