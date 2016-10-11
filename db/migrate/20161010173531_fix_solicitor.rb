class FixSolicitor < ActiveRecord::Migration[5.0]
  def change
    change_column :people, :solicitor, :string
  end
end
