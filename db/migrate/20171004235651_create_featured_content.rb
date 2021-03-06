class CreateFeaturedContent < ActiveRecord::Migration[5.1]
  def change
    create_table :featured_content do |t|
      t.integer :homepage_id, null: false
      t.references :content, polymorphic: true, null: false

      t.integer :position, null: false

      t.timestamps
    end
  end
end
