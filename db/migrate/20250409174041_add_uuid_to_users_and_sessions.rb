class AddUuidToUsersAndSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :uuid, :string, null: false
    add_index :users, :uuid, unique: true

    add_column :sessions, :uuid, :string, null: false
    add_index :sessions, :uuid, unique: true
  end
end
