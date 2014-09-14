class CceClass < ActiveRecord::Base
  belongs_to :user  
  has_many :courses, dependent: :destroy
  has_many :cce_class_dimensions, dependent: :destroy
  has_many :dimensions, through: :cce_class_dimensions
  accepts_nested_attributes_for :cce_class_dimensions
  
  validates :title, presence: {message: "課程名稱 不能是空白"}
  validates :kind, presence: {message: "課程類別 不能是空白"}
  validates :status, presence: {message: "課程狀態 不能是空白"}
  validates :school_year, presence: {message: "課程學年 不能是空白"}
  validates :start_at, presence: {message: "課程開始日 不能是空白"}    
  validates :end_at, presence: {message: "課程結束日 不能是空白"}    
  validates :total_hours, presence: {message: "課程總時數 不能是空白"}   
  validates :class_time, presence: {message: "上課時間 不能是空白"}    
  validates :location, presence: {message: "上課地點 不能是空白"}  
  validates :introduction, presence: {message: "課程介紹 不能是空白"}  
  validates :user_size_limits, presence: {message: "招生人數 不能是空白"}  
  validates :in_school_lecturers_quantity, presence: {message: "校內師資人數 不能是空白"}  
  validates :out_school_lecturers_quantity, presence: {message: "校外師資人數 不能是空白"}          
  validates :organizer, presence: {message: "主辦單位 不能是空白"}          
  validates :host, presence: {message: "主持人 不能是空白"}   
  validates :host_extend, presence: {message: "主持人學校分機 不能是空白"}     
  validates :tuition, presence: {message: "學費 不能是空白"}
  validates :total_tuition, presence: {message: "預估總共學費 不能是空白"}
  validates :school_expenses, presence: {message: "預計經費支出-學校 不能是空白"}      
  validates :school_venue_fee, presence: {message: "學校場地費 不能是空白"}      
  validates :units_venue_fee, presence: {message: "各單位場地費 不能是空白"}      




  validate  :kindIsCreditMostWithTotalCredits
 

  def kindIsCreditMostWithTotalCredits
    if total_credits.blank? and kind==GLOBAL_VAR['kind_credit'] 
      errors.add(:total_credits, "請填寫總學分")
    end
  end       
  
end
