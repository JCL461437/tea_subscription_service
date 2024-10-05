class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.string :title
      t.decimal :price, precision: 8, scale: 2 #currency set up 
      t.string :status, null: false, default: 'active'
      t.string :frequency, null: false

      t.timestamps
    end
  end
end
