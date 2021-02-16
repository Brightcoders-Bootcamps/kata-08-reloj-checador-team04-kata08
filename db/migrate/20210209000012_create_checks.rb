class CreateChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :checks do |t|
      t.integer :privatenumber
      t.string :type_move

      t.timestamps
    end
  end
end
