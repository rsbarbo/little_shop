class Order < ApplicationRecord
  has_many :ordered_items
  belongs_to :user
  has_many :items, through: :ordered_items

  def quantity(item_id)
    # byebug
    ordered_items.find_by(item_id: item_id).quantity
  end

  def subtotal(item_id)
    items.find(item_id).price * quantity(item_id)
  end

  def total
    quantities = ordered_items.pluck(:quantity)
    prices = items.pluck(:price)
    prices.zip(quantities).inject(0) do |result, (price, quantity)|
      result + price * quantity
    end
  end

  def change_status(status)
    update_attribute(:status, status)
  end

  def distinct_items
    items.distinct
  end

  def completed_or_cancelled?
    status == "Completed" || status == "Cancelled"
  end

  def quantity_sorted_items
    # ids = items.pluck(:ids)
    # byebug
    foo = items.to_a.sort_by do |item|
      quantity(item.id)
    end.reverse
    # byebug
    foo
  end
end
