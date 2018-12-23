class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates_presence_of :stripe_charge_id
  validates_presence_of :amount_in_cents
  validates_presence_of :card_last4
  validates_presence_of :card_exp_month
  validates_presence_of :card_exp_year
  validates_presence_of :card_type

end
