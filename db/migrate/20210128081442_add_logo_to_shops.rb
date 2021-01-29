class AddLogoToShops < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :logo, :string
  end
end
