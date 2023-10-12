class CreateCowDates < ActiveRecord::Migration[7.0]
  def change
    create_table :cow_dates do |t|
      t.integer :cow_tipping_id
      t.string :cow_name
      t.date :date
      t.boolean :match

      t.timestamps
    end
  end
end
