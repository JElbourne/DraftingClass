class Lesson < ApplicationRecord
  scope :is_published, -> {where(published: true)}

  belongs_to :course
  has_many :lesson_links

  validates_presence_of :title
  validates_presence_of :transcript
  validates_presence_of :video_url

  def self.get_by_id_if_published(id)
    if id.present?
        where(id: id, published: true).first
    else
        nil
    end
  end

end
