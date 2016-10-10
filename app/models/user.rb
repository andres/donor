class User < ApplicationRecord

  has_paper_trail

  has_secure_password
  
  validates :login, presence: true, uniqueness: true

  validates :password, length: {minimum: 8, maximum: 72}, allow_blank: true 

  scope :active, ->(){ where(active: true) }
  scope :by_name, ->(){ order(:login) }

  validate :at_least_one_admin

  module Validations
    def at_least_one_admin
      unless one_admin_remains
        self.errors.add(:base, "The system needs at least one active user")
      end
    end

    def one_admin_remains
      User.active.where('id != ?', self.id.to_i).any?
    end
  end
  include Validations

end

