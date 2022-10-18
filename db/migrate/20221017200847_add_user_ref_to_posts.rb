# frozen_string_literal: true

class AddUserRefToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :author, null: false, foreign_key: true, index: true
  end
end
