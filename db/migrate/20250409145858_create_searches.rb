class CreateSearches < ActiveRecord::Migration[8.0]
  def change
    create_table :searches do |t|
      t.string :text, null: false
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
