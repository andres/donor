class User < ApplicationRecord

  has_paper_trail

  has_secure_password
  
  validates :login, presence: true, uniqueness: true

  validates :password, length: {minimum: 8, maximum: 72}, allow_blank: true 

  scope :active, ->(){ where(active: true) }

end
