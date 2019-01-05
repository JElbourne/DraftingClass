require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:tag)).to be_valid
    end

    it { should validate_presence_of(:name) }

  end

  describe "associations" do
    it { should have_many(:taggings) }
    it { should have_many(:courses) }
    it { should have_many(:lessons) }
  end
end
