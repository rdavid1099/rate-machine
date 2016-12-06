class Rating < ApplicationRecord
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :stars, presence: true, inclusion: 0..5

  def self.for_product(product_id)
    self.where('product_id = ?', product_id)
  end
end
