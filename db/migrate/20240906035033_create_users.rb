class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      # User data
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :nickname
      t.string :password_digest

      # Trackable
      t.datetime :last_login_datetime
      t.integer :count_login, default: 0

      # Administration
      t.boolean :is_active, default: true
      t.timestamps
    end
  end
end
