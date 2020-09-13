class Video < ApplicationRecord
  YOUTUBE_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  validates :link, presence: true, format: YOUTUBE_LINK_FORMAT
  before_save :get_information

  private
  def get_information
    video = Yt::Video.new url: self.link
    self.uid = video.id
    self.title = video.title
    self.likes = video.like_count
    self.dislikes = video.dislike_count
    self.published_at = video.published_at
  rescue Yt::Errors::NoItems
    raise
  end
end
