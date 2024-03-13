# frozen_string_literal: true

class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name, index: true, null: false
      t.string :title
      t.integer :age

      t.timestamps
    end
  end
end
