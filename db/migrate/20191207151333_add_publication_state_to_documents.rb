class AddPublicationStateToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :publication_state, :string
  end
end
