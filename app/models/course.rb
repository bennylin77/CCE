class Course < ActiveRecord::Base
  belongs_to :cce_class
  validates :title, presence: {message: "名稱 不能是空白"}  

end
