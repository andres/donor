class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :business_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone_1
      t.string :phone_2
      t.integer :solicitor
      t.integer :created_by
      t.timestamps
    end
    add_index(:people, :first_name)
    add_index(:people, :last_name)
    add_index(:people, :business_name)
    add_index(:people, :solicitor)
  end
end
