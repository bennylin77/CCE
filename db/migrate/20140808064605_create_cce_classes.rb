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
      t.text :link 
      t.text :registration_link      
      t.attachment :attachment       
              
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
   
      t.integer :grants, default: 0  
      t.integer :total_tuition  
      t.integer :other_funds, default: 0  
      t.integer :user_size_limits
                  
      t.integer :total_credits  
      t.integer :total_hours
      t.integer :in_school_lecturers_quantity   
      t.integer :out_school_lecturers_quantity        
      
      t.integer :school_expenses, default: 0  
      t.integer :academic_expenses, default: 0        
      t.integer :center_expenses, default: 0    
      t.integer :college_expenses, default: 0    
      t.integer :department_expenses, default: 0    
      
      t.integer :school_venue_fee, default: 0  
      t.integer :units_venue_fee, default: 0    
      
      t.integer :personnel_fee, default: 0  
      t.integer :sales_fee, default: 0  
      t.integer :travel_fee, default: 0  
      t.integer :facilities_fee, default: 0                          
      t.integer :hourly_fee, default: 0  
            
      t.boolean :verified, default: false
      t.integer :verified_user_id    
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
