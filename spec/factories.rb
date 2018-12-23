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
    end

    factory :student do
        user
        course
    end

    factory :lesson do
      course
      title {"Lesson"}
      transcript {"This is a lesson"}
      video_url {"http://youtube.com/1234kjhg234khg234"}
      published { false }
    end


  end

  