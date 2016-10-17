class Donation < ApplicationRecord
  has_paper_trail

  belongs_to :person
  belongs_to :campaign

  validates :person_id, presence: true, numericality: true
  validates :campaign_id, presence: true, numericality: true
  validates :amount_cents, presence: true
  validates :date, presence: true

  monetize :amount_cents

end
