class Dimension < ActiveRecord::Base
  has_many :cce_class_dimensions, dependent: :destroy
  has_many :cce_classes, through: :cce_class_dimensions
end
