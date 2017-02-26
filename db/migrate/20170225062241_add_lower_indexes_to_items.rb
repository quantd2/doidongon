class AddLowerIndexesToItems < ActiveRecord::Migration[5.0]
  def up
    execute %{
      CREATE INDEX
        items_lower_name
      ON
        items (lower(name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX
        items_lower_description
      ON
        items USING gin (lower(description) gin_trgm_ops)
    }
  end

  def down
    remove_index :items, name: 'items_lower_name'
    remove_index :items, name: 'items_lower_description'
  end
end
