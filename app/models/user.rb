class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  has_many :submitted_urls,
  class_name: "ShortenedUrl",
  foreign_key: :submitter_id,
  primary_key: :id

  has_many :visits,
  class_name: "Visit",
  foreign_key: :user_id,
  primary_key: :id

  has_many :visited_urls,
  Proc.new { distinct },
  through: :visits,
  source: :shortened_url

  def self.find(search_data)
    if search_data.is_a?(Integer)
      super(search_data)
    elsif search_data.is_a?(String)
      self.where(email: search_data).first
    end
  end

end