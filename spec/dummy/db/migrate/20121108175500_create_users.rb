class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.decimal :goodles
      t.timestamps
    end
  end
end
