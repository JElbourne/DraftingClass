require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:user)).to be_valid
    end

  end

  describe "associations" do
    it { should have_many(:notifications) }
    it { should have_many(:services) }
    it { should have_many(:students) }
    it { should have_many(:courses) }
  end
end