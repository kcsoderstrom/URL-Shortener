class Visit < ActiveRecord::Base
  validates :shortened_url_id, :user_id, presence: true

  belongs_to :shortened_url,
  class_name: "ShortenedUrl",
  foreign_key: :shortened_url_id,
  primary_key: :id

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, shortened_url_id: shortened_url.id)
  end
  #
  # def self.matches_for_shortened_url_id(shortened_url_id)
  #   self.select { |visit| visit.shortened_url_id == shortened_url_id }
  # end
  #
  # def self.num_clicks_for_shortened_url_id(shortened_url_id)
  #   self.matches_for_shortened_url_id(shortened_url_id).count
  # end
  #
  # def self.num_uniques_for_shortened_url_id(shortened_url_id)
  #   self.matches_for_shortened_url_id(shortened_url_id).uniq.count
  # end

end