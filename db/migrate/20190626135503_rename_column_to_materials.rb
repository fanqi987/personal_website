class RenameColumnToMaterials < ActiveRecord::Migration[5.1]
  def change
    rename_column :materials, :type, :material_type
  end
end
