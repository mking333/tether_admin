class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.text :notes
      t.float :dest_lat
      t.float :dest_long
      t.datetime :depart_at
      t.datetime :arrive_at
      t.datetime :start_at
      t.datetime :finish_at
      t.string :authentication_token
      t.integer :pin
      t.references :user, index: true

      t.timestamps
    end
    add_index :trips, :authentication_token
  end
end
