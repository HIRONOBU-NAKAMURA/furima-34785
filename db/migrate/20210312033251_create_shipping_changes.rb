class CreateShippingChanges < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_changes do |t|

      t.timestamps
    end
  end
end
