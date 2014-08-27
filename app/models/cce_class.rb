class CceClass < ActiveRecord::Base
  has_many :cce_class_dimensions, dependent: :destroy
  has_many :dimensions, through: :cce_class_dimensions
  accepts_nested_attributes_for :cce_class_dimensions
end
