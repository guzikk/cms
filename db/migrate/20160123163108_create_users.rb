class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name, :limit=>20
      t.string :last_name, :limit=>60
      t.string :login, :limit=>25
      t.string :email, :limit=>100, :default=>'', :null => false
      t.string :phone_number, :default=>'', :null=>false
      t.string :password_digest

      t.timestamps null: false
    end
    add_index('users', 'login')
  end

  def down
    drop_table :users
  end

end
