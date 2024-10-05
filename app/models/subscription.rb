class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true, numericality: true 
  validates :status, presence: true
  validates :frequency, presence: true

  def cancel
    if self.status == "active"
      self.status = "cancelled"
    end
  end
end