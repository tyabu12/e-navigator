class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  enum gender: { male: 0, female: 1, other: 2 }

  has_many :interviews, dependent: :destroy
end
