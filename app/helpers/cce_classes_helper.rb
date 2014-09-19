module CceClassesHelper
  def statusOptions
    [['招生中', GLOBAL_VAR['status_enrollment']], 
     ['已開班', GLOBAL_VAR['status_under']], 
     ['已結業', GLOBAL_VAR['status_finished']],
     ['停開', GLOBAL_VAR['status_suspended']]     
     ]
  end    
  def kindOptions
    [['學分班', GLOBAL_VAR['kind_credit']], 
     ['培訓班', GLOBAL_VAR['kind_training']], 
     ['營隊', GLOBAL_VAR['kind_camp']]]
  end  
  def showDimensions(hash={})
    dimensions=Array.new
    hash[:cce_class].cce_class_dimensions.each do |d|    
      dimensions<<d.dimension.name
    end
    if dimensions.empty?
      '無向度'
    else
      dimensions.join(', ')   
    end
  end
  
  
    
end
