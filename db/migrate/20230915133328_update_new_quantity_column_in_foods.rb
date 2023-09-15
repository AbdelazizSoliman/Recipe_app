class UpdateNewQuantityColumnInFoods < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE foods SET new_quantity = (CASE WHEN quantity = 'true' THEN 1 ELSE 0 END);
    SQL
  end

  def down
    execute <<-SQL
      UPDATE foods SET quantity = (CASE WHEN new_quantity = 1 THEN 'true' ELSE 'false' END);
    SQL
  end
end
