class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_uid
      t.string :file_name,   null: true
      t.string :target_type, null: true
      t.integer :target_id,  null: true

      t.timestamps
    end
  end
end
