class AddMyimageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :myimage, :string
  end
end
