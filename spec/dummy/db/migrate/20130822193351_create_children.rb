class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :full_name
      t.integer :goodles
      t.integer :user_id

      t.timestamps
    end
  end

end
