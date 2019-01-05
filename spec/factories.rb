FactoryBot.define do
    factory :user do
      first_name {"Joe"}
      last_name {"Fresh"}
      email {"joe@gmail.com"}
      password {"blahblah"}
      admin { false }
    end

    factory :course do
        name {"Course"}
        description {"This is a course"}
        price {49}
        discount {0}
        published { false }
        image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    end

    factory :student do
        user
        course
    end

    factory :purchase do
      user
      course
      stripe_charge_id { "MyString" }
      amount_in_cents { 1 }
      card_last4 { "4323" }
      card_exp_month { 1 }
      card_exp_year { 22 }
      card_type { "Visa" }
    end

    factory :lesson do
      course
      title {"Lesson"}
      transcript {"This is a lesson"}
      length {100}
      video_url {"http://youtube.com/1234kjhg234khg234"}
      published { false }
      image { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
    end
    
    factory :tag do
      name { "MyString" }
    end

    factory :tagging do
      tag
      association :taggable, factory: :lesson
    end

  end

  