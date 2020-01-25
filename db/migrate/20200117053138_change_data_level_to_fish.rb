class ChangeDataLevelToFish < ActiveRecord::Migration[5.2]
  def change
      change_column :fish, :level, 'integer USING CAST (level as integer)'
  end
end
