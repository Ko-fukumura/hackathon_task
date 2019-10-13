class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def user
    return User.find(self.user_id)
  end
  
end
