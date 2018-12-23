require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:course)).to be_valid
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:discount) }
  end

  describe "associations" do
    it { should have_many(:lessons) }
    it { should have_many(:students) }
  end
end