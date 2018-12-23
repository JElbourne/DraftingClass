require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.create(:lesson)).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:transcript) }
    it { should validate_presence_of(:video_url) }
  end

  describe "associations" do
    it { should have_many(:lesson_links) }
    it { should belong_to(:course) }
  end
end