# frozen_string_literal: true

class CreateDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :details do |t|
      t.belongs_to :person, index: true, null: false
      t.string :email, null: false
      t.string :phone
      t.string :title
      t.integer :age

      t.timestamps
    end
  end
end
