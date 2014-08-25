# encoding: utf-8
class System < ActionMailer::Base
  default from: "國立交通大學推廣教育中心 <CCE@nctu.edu.tw>"
  helper ApplicationHelper  
  
  def sendVerification(hash={})
    @user=hash[:user]
    mail( to: hash[:user].email, subject: "國立交通大學推廣教育中心 會員邀請函" )
  end
  
end
