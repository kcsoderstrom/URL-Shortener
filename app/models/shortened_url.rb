require 'set'

class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :submitter_id, presence: true
  validates :short_url, uniqueness: true

  belongs_to :submitter,
  class_name: "User",
  foreign_key: :submitter_id,
  primary_key: :id

  has_many :visits,
  class_name: "Visit",
  foreign_key: :shortened_url_id,
  primary_key: :id

  has_many :visitors, through: :visits, source: :user

  def self.random_code
    loop do
      new_url = SecureRandom::urlsafe_base64[0...16]
      return new_url unless self.exists?(short_url: new_url)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!({
      submitter_id: user.id,
      long_url: long_url,
      short_url: "https://windows%20vista.info/#{self.random_code}"
    })
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    visitors.distinct.count
  end

  def num_recent_uniques(mins = 10)
    visitors.where("visits.updated_at > '#{mins.minutes.ago}'").distinct.count
  end

end