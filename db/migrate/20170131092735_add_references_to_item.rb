class AddReferencesToItem < ActiveRecord::Migration[5.0]
  def change
    add_reference :items, :location, foreign_key: true
  end
end
