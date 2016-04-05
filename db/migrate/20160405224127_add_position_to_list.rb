class AddPositionToList < ActiveRecord::Migration
  def change
    add_column :lists, :position, :integer
  end
end
