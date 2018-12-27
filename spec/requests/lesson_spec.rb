require 'rails_helper'

describe 'Lesson', type: :feature do
    describe 'VISIT #INDEX' do
        it 'allows VISITOR to view all Published lessons' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
            
            visit lessons_url
        
            expect(page).to have_content "PublishedLesson"
            expect(page).to_not have_content "UnPublishedLesson"
        end

        it 'allows USER to view all Published lessons' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
            user = FactoryBot.create(:user, password: 'password')

            login_as(user, scope: :user)

            visit lessons_url

            expect(page).to have_content "PublishedLesson"
            expect(page).to_not have_content "UnPublishedLesson"
        end

        it 'allows ADMIN to view ALL lessons' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
            admin = FactoryBot.create(:user, password: 'password', admin: true)

            login_as(admin, scope: :user)

            visit lessons_url

            expect(page).to have_content "PublishedLesson"
            expect(page).to have_content "UnPublishedLesson"
        end
    end

    describe 'VISIT #SHOW' do
        it 'allows VISITOR to view a Published lesson' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
             
            visit lessons_url
            click_link 'PublishedLesson'
        
            expect(current_path).to eq lesson_path(lesson_one)

            visit lesson_path(lesson_one)
            expect(current_path).to eq lesson_path(lesson_one)

            visit lesson_path(lesson_two)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'No Lesson Found.')
        end

        it 'allows USER to view a Published lesson' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
            user = FactoryBot.create(:user, password: 'password')

            login_as(user, scope: :user)

            visit lessons_url
            click_link 'PublishedLesson'
        
            expect(current_path).to eq lesson_path(lesson_one)

            visit lesson_path(lesson_one)
            expect(current_path).to eq lesson_path(lesson_one)

            visit lesson_path(lesson_two)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'No Lesson Found.')
        end

        it 'allows ADMIN to view ANY lesson' do
            lesson_one = FactoryBot.create(:lesson, title: "PublishedLesson", published: true)
            lesson_two = FactoryBot.create(:lesson, title: "UnPublishedLesson", published: false)
            admin = FactoryBot.create(:user, password: 'password', admin: true)

            login_as(admin, scope: :user)

            visit lessons_url
            click_link 'PublishedLesson'
            expect(current_path).to eq lesson_path(lesson_one)

            visit lessons_url
            click_link 'UnPublishedLesson'
            expect(current_path).to eq lesson_path(lesson_two)

            visit lesson_path(lesson_one)
            expect(current_path).to eq lesson_path(lesson_one)

            visit lesson_path(lesson_two)
            expect(current_path).to eq lesson_path(lesson_two)
        end 
    end

    describe 'VISIT #NEW' do
        it 'DOES NOT allow visitor to view NEW lesson form' do
            course = FactoryBot.create(:course)
            visit new_course_lesson_path(course.id)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'DOES NOT allow user to view NEW lesson form' do
            course = FactoryBot.create(:course)
            user = FactoryBot.create(:user, password: 'password')
            login_as(user, scope: :user)
            
            visit new_course_lesson_path(course.id)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'allows Admin to view NEW lesson form' do
            course = FactoryBot.create(:course)
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            
            visit new_course_lesson_path(course.id)
            expect(current_path).to eq new_course_lesson_path(course.id)
        end
    end

    describe 'VISIT #CREATE' do
        it 'allows Admin to CREATE new lesson' do
            course = FactoryBot.create(:course)
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            
            visit new_course_lesson_url(Course.last.id)
            fill_in 'lesson_title', with: 'New lesson'
            fill_in 'lesson_transcript', with: 'This is a lesson'
            fill_in 'lesson_video_url', with: 'youtube.com'
            click_button 'Create Lesson'

            lesson = Lesson.last
            expect(lesson.title).to eq 'New lesson'
            expect(current_path).to eq lesson_path(lesson)
        end
    end

    describe 'VISIT #EDIT' do

        before(:each) do
           @lesson = FactoryBot.create(:lesson)
        end
        
        it 'DOES NOT allow visitor to view EDIT lesson form' do
            visit edit_lesson_path(@lesson)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'DOES NOT allow user to view EDIT lesson form' do
            user = FactoryBot.create(:user, password: 'password')
            login_as(user, scope: :user)
            
            visit edit_lesson_path(@lesson)
            expect(current_path).to eq root_path
            expect(page).to have_selector('#message', text: 'Not authorized.')
        end

        it 'allows Admin to view EDIT lesson form' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            
            visit edit_lesson_path(@lesson)
            expect(current_path).to eq edit_lesson_path(@lesson)
        end
    end

    describe 'VISIT #UPDATE' do
        it 'allows Admin to UPDATE lesson' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            existing_lesson = FactoryBot.create(:lesson)
            
            visit edit_lesson_path(existing_lesson)
            fill_in 'lesson_title', with: 'Updated lesson'
            click_button 'Update Lesson'

            latest_lesson = Lesson.last
            expect(current_path).to eq lesson_path(latest_lesson)
            expect(latest_lesson.title).to eq 'Updated lesson'
        end
    end

    describe 'VISIT #DESTROY' do
        it 'allows Admin to DESTROY lesson' do
            admin = FactoryBot.create(:user, password: 'password', admin: true)
            login_as(admin, scope: :user)
            existing_lesson = FactoryBot.create(:lesson)
            
            visit edit_lesson_path(existing_lesson)
            click_link 'Destroy'

            expect(current_path).to eq lessons_path
            #expect(lesson.where(:name => existing_lesson.name).count).to eq 0
            expect(Lesson.count).to eq 0
        end
    end
end