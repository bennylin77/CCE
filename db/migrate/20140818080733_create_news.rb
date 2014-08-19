class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.belongs_to :cce_class, index: true
      t.string :title
      t.text :content
      t.integer :view
      t.attachment :cover

      t.timestamps
    end
  end
end
