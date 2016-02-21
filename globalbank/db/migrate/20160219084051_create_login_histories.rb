class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
      t.integer :user_id
      t.datetime :last_login

      t.timestamps null: false
    end
  end
end
