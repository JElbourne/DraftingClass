require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:student)).to be_valid
    end

  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:course) }
  end
end