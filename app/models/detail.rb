# frozen_string_literal: true

# == Schema Information
#
# Table name: details
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  email      :string           not null
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Detail < ApplicationRecord
  belongs_to :person, inverse_of: :details

  normalizes :email, with: ->(email) { email.squish.strip.downcase }

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: %r{\A[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+)*@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z} },
            on: :create
end
