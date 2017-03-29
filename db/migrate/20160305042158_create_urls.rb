class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_url, null: false
      t.string :strink, null: false, default: ""
      t.integer :visits, default: 0

      t.timestamps null: false
    end
  end
end
