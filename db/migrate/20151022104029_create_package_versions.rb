class CreatePackageVersions < ActiveRecord::Migration
  def change
    create_table :package_versions do |t|
      t.integer :package_id, null: false
      t.text    :name,       null: false
      t.text    :version,    null: false
      t.json    :payload

      t.timestamps null: false
    end

    add_index :package_versions, [:name, :version], unique: true
  end
end
