# encoding: UTF-8
require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :news, dependent: :destroy
  has_many :cce_classes
  
    
  validates :name, presence: {message: "姓名 不能是空白"}
  validates :email, presence: {message: "Email 不能是空白"}, uniqueness: {message: "Email 已註冊過"}
  validates :identity, presence: {message: "會員身份 不能是空白"}
  validates :pw, presence: {message: "密碼 不能是空白"}, confirmation: {message: "密碼 輸入不一致"}, on: :update
  validates :pw_confirmation, presence: {message: "密碼確認 不能是空白"}, on: :update
  validates :birthday, presence: {message: "出生年月日 不能是空白"}, on: :update  
  #validates :address, presence: {message: "地址 不能是空白"}, on: :update  
  validates :education, presence: {message: "最高學歷 不能是空白"}, on: :update  
  validates :mobile_no, presence: {message: "手機號碼 不能是空白"}, on: :update  

 
  
  
  validate  :identityMostWithExtend, on: :update
  validate  :passportNoOrIdNo, on: :update 
  
  def identityMostWithExtend
    if extend.blank? and identity!=GLOBAL_VAR['identity_student'] and identity!=GLOBAL_VAR['identity_lecturer']
      errors.add(:extend, "請填寫學校分機")
    end
  end    
  
  def passportNoOrIdNo 
    if id_no.blank? and nationality=="Taiwan, Republic Of China"
      errors.add(:id_no, "請填寫身分證字號")
    elsif passport_no.blank? and nationality!="Taiwan, Republic Of China" 
      errors.add(:passport_no, "請填寫護照號碼")      
    end    
  end
  
  
  def pw
    @pw
  end
  def pw=(pwd)
    @pw=pwd
    return if pwd.blank?
    createNewSalt
    self.hashed_pw=User.encryptedPassword(self.pw, self.salt)
  end
  
  def self.authenticate(email, password)
    user=self.find_by_email(email)
    unless user.blank?
      expectedPassword=encryptedPassword(password, user.salt)
      if user.hashed_pw!=expectedPassword or expectedPassword.blank?
        user=nil
      end
    end
    user
  end
  
private
  def createNewSalt
    self.salt = self.object_id.to_s+rand.to_s
  end
  
  def self.encryptedPassword(password, salt)
    unless salt.blank?
      string_to_hash=password+"CCE_test"+salt
      Digest::SHA1.hexdigest(string_to_hash)
    else
      nil
    end  
  end
  
end
