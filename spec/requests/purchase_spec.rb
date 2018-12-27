require 'rails_helper'

describe 'Purchase', type: :feature do
    describe 'VISIT #NEW' do
        it 'DOES NOT allow visitor to view NEW Purchase form' do
            course = FactoryBot.create(:course, name: "PublishedCourse", published: true)
             
            visit course_path(course)
            expect(current_path).to eq course_path(course)

            expect(page).to have_content('Buy Now')
            click_link 'Buy Now'

            expect(current_path).to eq new_user_session_path
        end

        it 'allow user to view NEW Purchase form' do
            course = FactoryBot.create(:course, name: "PublishedCourse", published: true)
             
            user = FactoryBot.create(:user, password: 'password', admin: false)
            login_as(user, scope: :user)

            visit course_path(course)
            expect(current_path).to eq course_path(course)

            expect(page).to have_content('Buy Now')
            click_link 'Buy Now'

            expect(current_path).to eq new_course_purchase_path(course)
        end

        it 'allows Admin to view NEW Purchase form' do
            course = FactoryBot.create(:course, name: "PublishedCourse", published: true)

            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)

            visit course_path(course)
            expect(current_path).to eq course_path(course)

            expect(page).to have_content('Buy Now')
            click_link 'Buy Now'

            expect(current_path).to eq new_course_purchase_path(course)
        end
    end

end
