class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :student_id, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

    add_index :users, :student_id, unique: true
  end
end
