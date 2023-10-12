class CreateCowTippings < ActiveRecord::Migration[7.0]
  def change
    create_table :cow_tippings do |t|
      t.string :name
      t.string :type
      t.string :farm

      t.timestamps
    end
  end
end
