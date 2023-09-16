class UpdateNewPublicColumnInRecipes < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE recipes SET new_public = (CASE WHEN public = 'true' THEN true ELSE false END);
    SQL
  end

  def down
    execute <<-SQL
      UPDATE recipes SET public = (CASE WHEN new_public = true THEN 'true' ELSE 'false' END);
    SQL
  end
end
