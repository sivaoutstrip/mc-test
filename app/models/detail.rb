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

  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP, on: :create
end
