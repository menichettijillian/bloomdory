class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string
    add_column :users, :last_name, :string
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
