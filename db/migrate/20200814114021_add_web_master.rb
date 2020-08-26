class AddWebMaster < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :web_master, :boolean
  end
end
