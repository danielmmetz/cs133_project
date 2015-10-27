class CreateMembers < ActiveRecord::Migration
  def change
    # create the table with timestamps
    create_table :members do |t|
      t.integer :draw_group_id
      t.integer :student_id
      t.timestamps null: false
    end

    # add foreign key columns
    add_foreign_key :members, :draw_groups, name: :group_id, on_delete: :cascade
    add_foreign_key :members, :students, name: :student_id, on_delete: :cascade
  end
end
