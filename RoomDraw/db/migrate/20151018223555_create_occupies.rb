class CreateOccupies < ActiveRecord::Migration
  def change
    create_table :occupies do |t|
      t.integer :student_id
      t.integer :room_id
      t.integer :academic_year
      t.boolean :in_fall?
      t.boolean :in_spring?

      t.timestamps null: false
    end

    add_foreign_key :occupies, :students
    add_foreign_key :occupies, :rooms
  end
end
