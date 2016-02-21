class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.decimal :amount, precision: 9, scale: 2
      t.string :txn_type
      t.string :remarks

      t.timestamps null: false
    end
  end
end
