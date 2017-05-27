class Article < ActiveRecord::Base
  # Add some validations to the :title and :description attributes
  validates :title, presence: true, length: { minimum: 3, maximum: 500 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000000 }
end
