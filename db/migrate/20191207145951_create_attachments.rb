class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.string :title
      t.string :content_type
      t.string :url
      t.references :document, null: false, foreign_key: true

      t.timestamps
    end
  end
end
