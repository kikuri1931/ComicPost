class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :payment
      t.integer :taxin_payment
      t.integer :status, defalut: 0, null: false
      t.timestamps
    end
  end
end
