class Article < ActiveRecord::Base
  belongs_to :user
  # Add some validations to the :title and :description attributes
  validates :title, presence: true, length: { minimum: 3, maximum: 500 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000000 }
  validates :user_id, presence: true
end
