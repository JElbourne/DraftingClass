require 'rails_helper'

describe 'Course', type: :feature do
    describe 'VISIT #INDEX' do
        it 'allows VISITOR to view all Published courses' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
            
            visit courses_url
        
            expect(page).to have_content "PublishedCourse"
            expect(page).to_not have_content "UnPublishedCourse"
        end

        it 'allows USER to view all Published courses' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
            user = FactoryBot.create(:user, password: 'password')

            login_as(user, scope: :user)

            visit courses_url

            expect(page).to have_content "PublishedCourse"
            expect(page).to_not have_content "UnPublishedCourse"
        end

        it 'allows ADMIN to view ALL courses' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
            admin = FactoryBot.create(:user, password: 'password', admin: true)

            login_as(admin, scope: :user)

            visit courses_url

            expect(page).to have_content "PublishedCourse"
            expect(page).to have_content "UnPublishedCourse"
        end
    end

    describe 'VISIT #SHOW' do
        it 'allows VISITOR to view a Published course' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
             
            visit courses_url
            click_link 'PublishedCourse'
        
            expect(current_path).to eq course_path(course_one)

            visit course_path(course_one)
            expect(current_path).to eq course_path(course_one)

            visit course_path(course_two)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'No Course Found.')
        end

        it 'allows USER to view a Published course' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
            user = FactoryBot.create(:user, password: 'password')

            login_as(user, scope: :user)

            visit courses_url
            click_link 'PublishedCourse'
        
            expect(current_path).to eq course_path(course_one)

            visit course_path(course_one)
            expect(current_path).to eq course_path(course_one)

            visit course_path(course_two)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'No Course Found.')
        end

        it 'allows ADMIN to view ANY course and it\'s Lessons' do
            course_one = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            course_two = FactoryBot.create(:course, name: "UnPublishedCourse", published: false)
            lesson_true = FactoryBot.create(:lesson, title: "Good", published: true, course: course_one)
            lesson_bad = FactoryBot.create(:lesson, title: "Bad", published: true)
            lesson_false = FactoryBot.create(:lesson, title: "False", published: false)
            admin = FactoryBot.create(:user, password: 'password', admin: true)

            login_as(admin, scope: :user)

            visit courses_url
            click_link 'PublishedCourse'
            expect(current_path).to eq course_path(course_one)

            visit courses_url
            click_link 'UnPublishedCourse'
            expect(current_path).to eq course_path(course_two)

            visit course_path(course_one)
            expect(current_path).to eq course_path(course_one)
            expect(page).to have_content("Good")
            expect(page).to_not have_content("Bad")
            expect(page).to_not have_content("False")

            visit course_path(course_two)
            expect(current_path).to eq course_path(course_two)
        end

        it 'allows SUBSCRIBER to view course lessons' do
            course = FactoryBot.create(:course, name: "PublishedCourse", published: true)
            lesson_true = FactoryBot.create(:lesson, title: "Good", published: true, course: course)
            lesson_bad = FactoryBot.create(:lesson, title: "Bad", published: true)
            lesson_false = FactoryBot.create(:lesson, title: "False", published: false)

            user = FactoryBot.create(:user, password: 'password')
            student = FactoryBot.create(:student, user: user, course: course)

            login_as(user, scope: :user)
            visit course_path(course)

            expect(page).to have_content("Good")
            expect(page).to_not have_content("Bad")
            expect(page).to_not have_content("False")
        end
    end

    describe 'VISIT #NEW' do
        it 'DOES NOT allow visitor to view NEW course form' do
            visit courses_url
            expect(page).to_not have_content('Add New Course')

            visit new_course_url
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'DOES NOT allow user to view NEW course form' do
            user = FactoryBot.create(:user, password: 'password')
            login_as(user, scope: :user)

            visit courses_url
            expect(page).to_not have_content('Add New Course')
            
            visit new_course_url
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'allows Admin to view NEW course form' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
           
            visit new_course_url
            expect(current_path).to eq new_course_path
        end
    end

    describe 'VISIT #CREATE' do
        it 'allows Admin to CREATE new course' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            
            visit new_course_url
            fill_in 'course_name', with: 'New Course'
            fill_in 'course_description', with: 'This is a course'
            fill_in 'course_price', with: '49'
            fill_in 'course_discount', with: '0'
            click_button 'Create Course'

            course = Course.last
            expect(current_path).to eq course_path(course)
        end
    end

    describe 'VISIT #EDIT' do

        before(:each) do
           @course = FactoryBot.create(:course)
        end
        
        it 'DOES NOT allow visitor to view EDIT course form' do
            visit edit_course_path(@course)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'DOES NOT allow user to view EDIT course form' do
            user = FactoryBot.create(:user, password: 'password')
            login_as(user, scope: :user)
            
            visit edit_course_path(@course)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'allows Admin to view EDIT course form' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            
            visit edit_course_path(@course)
            expect(current_path).to eq edit_course_path(@course)
        end
    end

    describe 'VISIT #UPDATE' do
        it 'allows Admin to UPDATE course' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            existing_course = FactoryBot.create(:course)
            
            visit edit_course_path(existing_course)
            fill_in 'course_name', with: 'Updated Course'
            click_button 'Update Course'

            latest_course = Course.last
            expect(current_path).to eq course_path(latest_course)
            expect(latest_course.name).to eq 'Updated Course'
        end
    end

    describe 'VISIT #DESTROY' do
        it 'allows Admin to DESTROY course' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            existing_course = FactoryBot.create(:course)
            
            visit edit_course_path(existing_course)
            click_link 'Destroy'

            expect(current_path).to eq courses_path
            #expect(Course.where(:name => existing_course.name).count).to eq 0
            expect(Course.count).to eq 0
        end
    end
end