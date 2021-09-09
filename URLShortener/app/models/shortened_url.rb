# == Schema Information
#
# Table name: shortened_urls
#
#  id           :bigint           not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, uniqueness: true, presence: true
    
    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :submitter_id,
        class_name: :User

    has_many :visits,
        primary_key: :id,
        foreign_key: :url_id,
        class_name: :Visit
        
    def self.random_code
        short_url = nil
        until short_url
            test = SecureRandom.urlsafe_base64(16)
            short_url = test unless ShortenedUrl.exists?(test)
        end
        short_url
    end

    def self.create!(user, l_url)
       s_url = ShortenedUrl.random_code
       ShortenedUrl.create(long_url: l_url, short_url: s_url,submitter_id: user.id)
    end
end
