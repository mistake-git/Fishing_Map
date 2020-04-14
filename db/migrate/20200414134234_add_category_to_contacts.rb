class AddCategoryToContacts < ActiveRecord::Migration[5.2]
  def change
     add_column :contacts, :category, :string
  end
end
