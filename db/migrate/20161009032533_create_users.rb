class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string  :login
      t.string  :password_digest
      t.boolean :active, default: true, null: false
      t.integer :created_by
      t.timestamps
    end
    add_index(:users, :login)
    add_index(:users, [:login, :active])
    add_index(:users, :password_digest)
  end
end
