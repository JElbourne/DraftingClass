require "rails_helper"

describe PurchasesController, type: :controller do

    describe 'VISIT #CREATE' do
        
        before(:each) do
            @stripe_test_helper = StripeMock.create_test_helper
            StripeMock.start
        end
        after(:each) do
            StripeMock.stop
        end

        it 'allows USER to complete a purchase and creates STUDENT' do
            course = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            user = FactoryBot.create(:user, password: 'password', admin: false)
            
            @request.env["devise.mapping"] = Devise.mappings[:user]
            sign_in user

            path = "/courses/#{course.id}/purchases"
            post :create, params: {course_id: course.id, stripeToken: @stripe_test_helper.generate_card_token}
            expect(response.status).to eq(200)

            expect(Student.count).to eq(1)
        end
    end
end