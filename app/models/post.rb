class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :likes_by, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true,
                    length: { minimum: 3 }

  scope :popular_posts, -> { joins(:likes).group('id').order('COUNT(post_id) DESC') }
  
  def liked?(user)
    likes_by.include?(user)
  end

  def like(user)
    likes_by << user
  end

  def unlike(user)
    likes_by.delete(user)
  end
end
