module CceClassesHelper
  def statusOptions
    [['招生中', GLOBAL_VAR['status_enrollment']], 
     ['已開班', GLOBAL_VAR['status_under']], 
     ['已結業', GLOBAL_VAR['status_finished']]]
  end    
  def kindOptions
    [['學分班', GLOBAL_VAR['kind_credit']], 
     ['培訓班', GLOBAL_VAR['kind_training']], 
     ['營隊', GLOBAL_VAR['kind_camp']],      
     ['單獨課程', GLOBAL_VAR['kind_course']]]
  end    
end
