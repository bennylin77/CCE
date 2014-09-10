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
      t.integer :tuition      
      t.text :lecturers      
      t.text :class_time
      t.text :note 
 
      t.integer :school_year      
      t.date :start_at
      t.date :end_at
      t.string :requester
      t.string :organizer
      t.string :other_organizer       
      t.string :host
      t.integer :host_extend
      t.belongs_to :user, index: true               
      t.string :location
   
      t.integer :grants
      t.integer :total_tuition
      t.integer :other_funds
      t.integer :user_size_limits
                  
      t.integer :total_credits
      t.integer :total_hours
      t.integer :in_school_lecturers_no    
      t.integer :out_school_lecturers_no         
      
      t.integer :school_expenses
      t.integer :academic_expenses      
      t.integer :center_expenses  
      t.integer :college_expenses  
      t.integer :department_expenses  
      
      t.integer :school_venue_fee
      t.integer :units_venue_fee    
            
      t.boolean :verified, default: false
      t.integer :verified_user_id    
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
