class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :email
      t.string :name
      t.string :position
      t.integer :privatenumber

      t.timestamps
    end
  end
end
