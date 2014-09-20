class EdmNews < ActiveRecord::Base
  belongs_to :edm
  belongs_to :news
  accepts_nested_attributes_for :news
  
end
