class Task < ActiveRecord::Base

  validates :title, presence: true,
                    uniqueness: true

  validates :due_date, presence: true

end
