class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :likes_by, through: :likes, source: :user
  has_many :comments
  has_many :commentators, through: :comments, source: :user
  validates :title, presence: true,
                    length: {minimum: 3}
                
  scope :popular_posts, -> {includes(:likes).group('post_id').order('COUNT(post_id) DESC').references(:likes)}
  
  
  def add_commentator(user)
    commentators << user
  end

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
