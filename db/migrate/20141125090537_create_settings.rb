class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.hstore :site_name, null: true
      t.hstore :site_title, null: true
      t.string :contact_email, null: true
      t.string :logo_uid, null: true

      t.timestamps
    end
  end
end
