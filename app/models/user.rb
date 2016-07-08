class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  has_many :projects, dependent: :nullify
  
  has_many :favourites, dependent: :destroy
  has_many :favourited_projects, through: :favourites, source: :project

  has_many :members, dependent: :destroy
  has_many :memberships, through: :members, source: :project

  def full_name
    "#{first_name} #{last_name}"
  end
end
