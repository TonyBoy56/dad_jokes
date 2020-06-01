
class AddUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.column :email, :string
      t.column :password_hash, :string
      t.column :password_salt, :string
      t.string :name
    end
  end
end
