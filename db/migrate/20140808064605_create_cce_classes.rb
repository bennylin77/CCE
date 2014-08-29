class CreateCceClasses < ActiveRecord::Migration
  def change
    create_table :cce_classes do |t|
      t.string :title
      t.string :sub_title
      t.integer :kind
      t.integer :status
      t.text :introduction
      t.text :syllabus
      t.text :schedule
      t.text :enrollment_user
      t.text :future
      t.string :location
      t.string :tuition
      t.text :lecturers
      t.date :start_at
      t.date :end_at
      t.text :class_time
      t.integer :user_size_limits
      t.integer :member_id
      t.text :note
      t.boolean :verified, default: false
      t.integer :verified_user_id    
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
