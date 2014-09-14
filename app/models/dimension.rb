class Dimension < ActiveRecord::Base
  has_many :cce_class_dimensions, dependent: :destroy
  has_many :cce_classes, through: :cce_class_dimensions
  validates :name, uniqueness: {message: "名稱 已經使用過" }, presence: {message: "名稱 不能是空白"}  
end
