class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.decimal :amount, precision: 9, scale: 2
      t.string :address
      t.integer :phone
      t.string :status, default: 'Open'

      t.timestamps null: false
    end
  end
end
