class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true, numericality: true 
  validates :status, presence: true
  validates :frequency, presence: true

  def change_status
    if self.status == "active"
      self.status = "cancelled"
    elsif self.status == "cancelled"
      self.status = "active"
    end
  end
end