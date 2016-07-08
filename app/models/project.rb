class Project < ActiveRecord::Base

  has_many :tasks, dependent: :destroy

  has_many :discussions, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: true

  validates :description, presence: true

  validates :due_date, presence: true

  has_many :favourites, dependent: :destroy
  has_many :users, through: :like

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :members, dependent: :destroy
  has_many :added_users, through: :members

  def favourited_by?(user)
    favourites.exists?(user: user)
  end

  def favourite_for(user)
    favourites.find_by_user_id(user)
  end

  def member_of(user)
    members.find_by_user_id(user)
  end

  def joined_by?(user)
    members.exists?(user: user)
  end

end
