class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.maximum_micropost_length}
  validate  :picture_size

  scope :by_desc, ->{order created_at: :desc}
  scope :feed, (lambda do |user|
                  where(select("followed_id")
                  .from("relationships")
                  .where("followed_id = ?", user).include?(:user_id))
                  .or(where("user_id = user"))
                end)

  private
  def picture_size
    return unless picture.size > Settings.maximum_img_size.megabytes
    errors.add :picture, I18n.t(".size_warning")
  end
end
