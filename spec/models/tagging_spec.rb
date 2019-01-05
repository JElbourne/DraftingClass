require 'rails_helper'

RSpec.describe Tagging, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:tagging)).to be_valid
    end

  end

  describe "associations" do
    it { should belong_to(:tag) }
    it { should belong_to(:taggable) }
  end
end
