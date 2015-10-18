class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.integer :sid
      t.string :draw_num
      t.string :integer
      t.integer :grad_year

      t.timestamps null: false
    end
  end
end
