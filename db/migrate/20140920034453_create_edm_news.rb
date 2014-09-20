class CreateEdmNews < ActiveRecord::Migration
  def change
    create_table :edm_news do |t|
      t.belongs_to :edm, index: true
      t.belongs_to :news, index: true

      t.timestamps
    end
  end
end
