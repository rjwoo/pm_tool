class Project < ActiveRecord::Base

  has_many :discussions, dependent: :destroy

  validates :title, presence: true,
                    uniqueness: true

  validates :description, presence: true

  validates :due_date, presence: true

end
