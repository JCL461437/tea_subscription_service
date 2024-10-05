class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true 
  validates :status, presence: true
  validates :frequency, presence: true
end