require 'rails_helper'

describe 'Navmenu', type: :feature do
    it 'allows visiting SCREENCAST LESSONS page by clicking Screencasts link' do
        visit root_path
        click_link "Screencasts"
        
        within('h1') do
            expect(page).to have_content "Screencasts"
        end
    end

    it 'allows visiting COURSES page by clicking Courses link' do
        visit root_path
        click_link "Courses"

        within('h1') do
            expect(page).to have_content "Courses"
        end
    end

    it 'allows visiting COMMUNITY page by clicking Community link' do
        visit root_path
        click_link "Community"

        within('h1') do
            expect(page).to have_content "Community"
        end
    end

    it 'allows visiting NEWS page by clicking Whats New link' do
        visit root_path
        click_link "What's New"

        within('h1') do
            expect(page).to have_content "What's New"
        end
    end

    it 'allows visiting LOGIN page by clicking Login link' do
        visit root_path
        click_link "Login"

        within('h1') do
            expect(page).to have_content "Log in"
        end
    end

    it 'allows visiting SIGN UP page by clicking Get Started link' do
        visit root_path
        click_link "Get started"

        within('h1') do
            expect(page).to have_content "Sign Up"
        end
    end
end