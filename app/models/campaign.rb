class Campaign < ApplicationRecord
  has_paper_trail

  has_many :donations

  validates :label, presence: true, uniqueness: true
  validates :date, presence: true

  def total_donations
    self.donations.inject(0){|t,d| t += d.amount }
  end
end

