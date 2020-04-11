class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :update_type
      t.string :base_path
      t.text :body
      t.text :summary

      t.timestamps
    end
  end
end
