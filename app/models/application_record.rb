# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  def initialize(*)
    super
  rescue ArgumentError
    raise if valid?
  end

  primary_abstract_class
end
