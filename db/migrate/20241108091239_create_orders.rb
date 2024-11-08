class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :side
      t.string :base_currency
      t.string :quote_currency
      t.decimal :price
      t.decimal :volume
      t.string :state

      t.timestamps
    end
  end
end
