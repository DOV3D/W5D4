# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  visitor_id :integer          not null
#  url_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Visit < ApplicationRecord
    validates :visitor_id, :url_id, presence: true

    belongs_to :visitor,
        primary_key: :id,
        foreign_key: :visitor_id,
        class_name: :User

    belongs_to :visited,
        primary_key: :id,
        foreign_key: :url_id,
        class_name: :ShortenedUrl

    def self.record_visit!(user, shortened_url)
        Visit.create(user.id, shortened_url.id)
    end
    
end
