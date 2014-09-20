class Edm < ActiveRecord::Base
  belongs_to :user
  has_many :edm_news, dependent: :destroy
  has_many :news, through: :edm_news
  accepts_nested_attributes_for :edm_news
  validates :title, presence: {message: "郵件標題 不能是空白"}

end
