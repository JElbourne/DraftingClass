require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:purchase)).to be_valid
    end

    it { should validate_presence_of(:stripe_charge_id) }
    it { should validate_presence_of(:amount_in_cents) }
    it { should validate_presence_of(:card_last4) }
    it { should validate_presence_of(:card_exp_month) }
    it { should validate_presence_of(:card_exp_year) }
    it { should validate_presence_of(:card_type) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end
end
