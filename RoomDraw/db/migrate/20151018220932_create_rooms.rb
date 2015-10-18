class CreateRooms < ActiveRecord::Migration
  def change
    # create the Rooms table
    create_table :rooms do |t|
      t.string :dorm_name
      t.string :room_num
      t.integer :capacity
      t.integer :collection_id

      t.timestamps null: false
    end
  end
end
