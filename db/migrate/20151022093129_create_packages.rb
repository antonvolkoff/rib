class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.text :name,             null: false, unique: true
      t.text :current_version
      t.json :payload

      t.timestamps null: false
    end
  end
end
