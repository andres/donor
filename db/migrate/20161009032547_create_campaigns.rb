class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :label
      t.date   :date
      t.text   :note
      t.integer :created_by
      t.timestamps
    end
    add_index(:campaigns, :date)
    add_index(:campaigns, :label)
  end
end
