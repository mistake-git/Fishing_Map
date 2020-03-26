class AddShareToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :share, :string
  end
end
