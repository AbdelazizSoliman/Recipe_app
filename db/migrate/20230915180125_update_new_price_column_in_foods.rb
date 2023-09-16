class UpdateNewPriceColumnInFoods < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE foods SET new_price = (CASE WHEN price = 'true' THEN 1 ELSE 0 END);
    SQL
  end

  def down
    execute <<-SQL
      UPDATE foods SET price = (CASE WHEN new_price = 1 THEN 'true' ELSE 'false' END);
    SQL
  end
end
