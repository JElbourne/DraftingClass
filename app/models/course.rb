class Course < ApplicationRecord

    scope :is_published, -> {where(published: true)}

    has_one_attached :image
    has_many :students
    has_many :lessons

    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :price
    validates_presence_of :discount

    def self.get_by_id_if_published(id)
        if id.present?
            where(id: id, published: true).first
        else
            nil
        end
    end
end
