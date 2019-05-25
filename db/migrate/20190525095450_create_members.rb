class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :member_type
      t.integer :duration
      t.string :role

      t.timestamps
    end
  end
end
