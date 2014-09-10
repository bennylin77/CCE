module ApplicationHelper
  def domain
    'http://140.113.151.67:10103'
  end
  def showBlank(hash={})
    if hash[:data].blank?
      '--'
    else  
      simple_format(hash[:data], {}, wrapper_tag: "span")
    end
  end  
  
end
