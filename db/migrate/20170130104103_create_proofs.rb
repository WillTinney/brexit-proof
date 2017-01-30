class CreateProofs < ActiveRecord::Migration[5.0]
  def change
    create_table :proofs do |t|
      t.string :document
      t.string :title
      t.string :comments
      t.references :user

      t.timestamps
    end
  end
end
