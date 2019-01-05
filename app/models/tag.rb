class Tag < ApplicationRecord
    has_many :taggings

    has_many :lessons, through: :taggings, source: :taggable, source_type: Lesson
    has_many :courses, through: :taggings, source: :taggable, source_type: Course

    validates_presence_of :name

end
