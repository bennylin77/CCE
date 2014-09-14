# encoding: utf-8
class News < ActiveRecord::Base
  belongs_to :cce_class
  belongs_to :user
  has_attached_file :cover,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :processors=> [:thumbnail, :compression]
  has_attached_file :DM,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename",
                    :processors=> [:thumbnail, :compression]
                      
  validates_attachment :cover, content_type: { :content_type =>['image/jpeg', 'image/png', 'image/gif'], :message => "圖片格式錯誤" }, 
                                               :size=>{ :less_than => 20.megabytes, :message => "圖片大小超過20MB" }  
end
