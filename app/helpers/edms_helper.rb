module EdmsHelper
  def showNews(hash={})
    news=Array.new
    hash[:edm].edm_news.each do |d|    
      news<<d.news.title+" "+d.news.created_at.strftime("%Y-%m-%d")
    end
    if news.empty?
      '無相關課程'
    else
      news.join('<br>')   
    end
  end

end
