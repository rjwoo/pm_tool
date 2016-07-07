class Tag < ActiveRecord::Base

  has_many :taggings, dependent: :destroy
  has_many :projects, through: :taggings

end
