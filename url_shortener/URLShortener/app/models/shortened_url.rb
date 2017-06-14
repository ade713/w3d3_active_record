# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def self.random_code
    short_url = SecureRandom.urlsafe_base64
    unless exists?(short_url)
      short_url = SecureRandom.urlsafe_base64
    end
    short_url
  end

  def self.generate_short(user, long_url)
    ShortenedUrl.create(short_url: ShortenedUrl.random_code, long_url: long_url, user_id: user.id)
  end
end
