class Person < ApplicationRecord
  has_paper_trail

  has_many :donations

  scope :by_name, ->(){ order([:last_name, :first_name, :business_name])}

  validate :validate_some_name
  validate :validate_address

  def total_donations
    self.donations.inject(0){|t,d| t += d.amount}
  end

  def last_donation
    @last_donation ||= self.donations.order(:date).last
  end

  module CustomValidations
    def validate_some_name
      unless some_name_present
        self.errors.add(:base, "First, Last, or Business name must be present")
      end
    end

    def some_name_present
      first_name.present? || last_name.present? || business_name.present?
    end

    def validate_address
      unless all_address_fields
        self.errors.add(:base, "All basic address fields must be present")
      end
    end

    def all_address_fields
      address_1.present? && city.present? && state.present? && zip.present?
    end
  end
  include CustomValidations

  module Helpers
    def screen_name
      (self.first_name.to_s + ' ' +
         self.last_name.to_s + ' ' +
         self.business_name.to_s).
       strip
    end
  end
  include Helpers
end
