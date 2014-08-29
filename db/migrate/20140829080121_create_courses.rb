class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.belongs_to :cce_class, index: true
      t.string :title

      t.timestamps
    end
  end
end
