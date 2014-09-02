class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :email
      t.integer :pin
      t.string :name
      t.boolean :leader
      t.float :current_lat
      t.float :current_long
      t.datetime :depart_at
      t.datetime :arrive_at
      t.datetime :join_at
      t.datetime :quit_at
      t.datetime :checkin_at
      t.string :status
      t.references :trip, index: true

      t.timestamps
    end
  end
end
