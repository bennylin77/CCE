class CreateCceClassDimensions < ActiveRecord::Migration
  def change
    create_table :cce_class_dimensions, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.belongs_to :cce_class, index: true
      t.belongs_to :dimension, index: true

      t.timestamps
    end
  end
end
