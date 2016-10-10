class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.date :date
      t.integer :person_id
      t.integer :campaign_id
      t.integer :amount_cents
      t.string  :donation_type
      t.integer :created_by
      t.timestamps
    end
    add_index(:donations, :date)
    add_index(:donations, :person_id)
    add_index(:donations, :campaign_id)
    add_index(:donations, :amount_cents)
    add_index(:donations, :donation_type)
  end
end
