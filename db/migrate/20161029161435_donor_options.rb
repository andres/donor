class DonorOptions < ActiveRecord::Migration[5.0]
  def change
    add_column(:people, :ok_to_email, :boolean, default: true, null: false)
    add_column(:people, :ok_to_mail,  :boolean, default: true, null: false)
    add_column(:people, :ok_to_call,  :boolean, default: true, null: false)
    add_index(:people, :ok_to_email)
    add_index(:people, :ok_to_mail)
    add_index(:people, :ok_to_call)
  end
end
