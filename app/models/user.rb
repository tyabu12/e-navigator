class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :recoverable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  enum gender: { male: 0, female: 1, other: 2 }

  has_many :interviews, dependent: :destroy

  def age
    d1 = self.birthday.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end

  def email_with_name
    "#{self.name} <#{self.email}>"
  end

  def self.all_except(id)
    where.not(id: id)
  end

end
