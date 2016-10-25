class Post < ApplicationRecord
  # act as votabale
  acts_as_votable
  # associated on the user table
  belongs_to :user
  has_many :comments

  # this is for paperclip
  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  # user friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  private
  # when updating the title of the post, update also the slug
  def should_generate_new_friendly_id?
    title_changed?
  end

end
