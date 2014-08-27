class CceClassDimension < ActiveRecord::Base
  belongs_to :cce_class
  belongs_to :dimension
  accepts_nested_attributes_for :dimension
end
