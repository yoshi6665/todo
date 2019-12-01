class User < ApplicationRecord
  validates :username, presence: true, length: {maximum:15}

  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i }

  validates :email, presence: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  has_secure_password

  has_many :tasks
end
