class ChangeTypeToBreed < ActiveRecord::Migration[7.0]
  def change
    rename_column :cow_tippings, :type, :breed
  end
end
