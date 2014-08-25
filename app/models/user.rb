# encoding: UTF-8
require 'digest/sha1'
class User < ActiveRecord::Base

  validates :name, presence: {message: "姓名 不能是空白"}
  validates :email, presence: {message: "Email 不能是空白"}, uniqueness: {message: "Email 已註冊過"}
  validates :identity, presence: {message: "身份 不能是空白"}
  validates :pw, presence: {message: "密碼 不能是空白"}, confirmation: {message: "密碼 輸入不一致"}, on: :update
  validates :pw_confirmation, presence: {message: "密碼確認 不能是空白"}, on: :update
  
  
  
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
      if user.hashed_pw!=expectedPassword
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
    string_to_hash=password+"CCE_test"+salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
end
