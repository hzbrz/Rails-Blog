class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  # Create a new feature branch called user-validations and do the validations there

  before_save { self.email = email.downcase }

  validates :username, presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 105 },
            format: { with: VALID_EMAIL_REGEX }

  # Then create another feature branch when adding the foreign key associations call that - userarticle-associations
  has_secure_password
  # added user: Hasan Z pass: password123
end
