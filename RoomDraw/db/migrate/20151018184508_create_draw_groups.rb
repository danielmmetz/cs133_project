class CreateDrawGroups < ActiveRecord::Migration
  def change
    create_table :draw_groups do |t|
      t.integer :student_id
      t.integer :draw_num
      t.boolean :for_suite?
      t.timestamps null: false
    end

    # add the id for the student representative.
    add_foreign_key :draw_groups, :students, name: :rep_id

  end
end
