module UsersHelper
  def identityOptions
    [['學生', GLOBAL_VAR['identity_student']], 
     ['教師', GLOBAL_VAR['identity_lecturer']], 
     ['行政人員', GLOBAL_VAR['identity_employee']]]
  end  
end
