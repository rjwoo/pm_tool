class Project < ActiveRecord::Base

  validates :title, presence: true,
                    uniqueness: true

  validates :description, presence: true

  validates :due_date, presence: true

end
